//
//  WFDSOperation.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFDSOperation+Internal.h"
#import "wfdao.h"
#import <objc/runtime.h>
#import "WFDSEntityHints+Internal.h"
#import "WFDSConnection+Internal.h"

@implementation WFDSOperation{
    NSUInteger _c;
}
+(NSSet<NSString *> *)connection:(WFDSConnection *)connection columnLabelsForTable:(NSString *)table exclude:(NSString *)exclude{
    static NSMutableDictionary<NSString *, NSMutableSet<NSString *> *> *DICTIONARY;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DICTIONARY= [NSMutableDictionary dictionary];
    });
    NSMutableSet *labels = DICTIONARY[table];
    if (!labels) {
        labels = [NSMutableSet set];
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE 0=1", table];
        WFDSStatement *statement = [connection prepareStatement:sql];
        sqlite3_stmt *stmt = statement.stmt;

        int n = sqlite3_column_count(stmt);
        for (int i = 0; i < n; i++) {
            const char *c = sqlite3_column_name(stmt, i);
            [labels addObject:@(c)];
        }
        [statement close];
        DICTIONARY[table] = labels;
    }
    NSMutableSet<NSString *> *excludes = [NSMutableSet set];
    if (exclude.length > 0) {
        NSArray<NSString *> *tokens = [exclude componentsSeparatedByString:@","];
        for (NSString *t in tokens) {
            NSString *column = [t stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
            [excludes addObject:column];
        }
    }
    NSMutableSet *set = labels.mutableCopy;
    [set minusSet:excludes];
    return set;
}
-(instancetype)initWithElement:(id<WFDSScriptAccess>)element{
    self = [super init];
    if (self) {
        _definition = [[WFDSOperationDefinition alloc] init];
        _definition.selectorName = element.selector;
        _definition.selector = NSSelectorFromString(element.selector);
        _definition.trace = element.trace;
        _definition.sql = [element.value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    }
    return self;
}
-(void)performInvocation:(NSInvocation *)invocation{
    WFDSStatement *statement = [self.dao.connection prepareStatement:self.definition.sql];
    @try {
        [self statement:statement bindParametersWithArgumentsFromInvocation:invocation];
        if (self.definition.trace) {
            wfdao_infoA(self, @"Execute SQL ...");
        }
        _c = [statement executeUpdate];
        [invocation setReturnValue:&_c];
    } @catch (NSException *exception) {
        @throw exception;
    } @finally {
        [statement close];
    }
}
-(void)statement:(WFDSStatement *)statement bindParametersWithArgumentsFromInvocation:(NSInvocation *)invocation{
    NSMethodSignature *signature = invocation.methodSignature;
    int argCount = (int)signature.numberOfArguments - 2;
    
    // arguments = 0
    if (argCount == 0) {
        return;
    }
    unsigned char buf[128];
    sqlite3_stmt *stmt = statement.stmt;
    
    // arguments > 1
    if (argCount > 1) {
        int paramCount = sqlite3_bind_parameter_count(stmt);
        if (paramCount != argCount) {
            @throw wfdao_exception(self, @"Bind arguments failed. Statement has %d arguments but selector '%@' provide %d.", paramCount, NSStringFromSelector(invocation.selector), argCount);
        }
        for (int i = 2, c = argCount + 2; i < c; i++) {
            [invocation getArgument:buf atIndex:i];
            [self statement:stmt bindParameterAtIndex:i - 1 withArgument:buf type:[signature getArgumentTypeAtIndex:i]];
        }
        return;
    }
    
    // arguments = 1
    [invocation getArgument:buf atIndex:2];
    const char *type = [signature getArgumentTypeAtIndex:2];
    if ([self statement:stmt bindParameterAtIndex:1 withArgument:buf type:type]) {
        return;
    }
    if (type[0] != _C_ID) {
        @throw wfdao_exception(self, @"Bind argument failed. Incompatible argument type.");
    }
    
    // bind entity
    id obj = *((__unsafe_unretained id *)(void *)buf);
    for (int i = 1, c = sqlite3_bind_parameter_count(stmt); i <= c; i++) {
        const char *label = sqlite3_bind_parameter_name(stmt, i);
        NSString *name = @(label + 1); // ignore the leading ':'.
        id value =  [obj valueForKey:name];
        if (value == nil) {
            sqlite3_bind_null(stmt, i);
        } else if ([value isKindOfClass:NSString.class]) {
            NSString *text = value;
            sqlite3_bind_text(stmt, i, text.UTF8String, (int)text.length, SQLITE_STATIC);
        } else if ([value isKindOfClass:NSNumber.class]) {
            NSNumber *number = value;
            switch (number.objCType[0]) {
                case _C_LNG_LNG:
                    sqlite3_bind_int64(stmt, i, number.integerValue);
                    break;
                case _C_CHR: // BOOL
                    sqlite3_bind_int64(stmt, i, number.boolValue);
                    break;
                case _C_DBL:
                    sqlite3_bind_double(stmt, i, number.doubleValue);
                    break;
                default:
                    @throw wfdao_exception(self, @"Bind argument failed. Entity: '%@', Property: '%@'.", NSStringFromClass([obj class]), name);
                    break;
            }
        } else if ([value isKindOfClass:NSDate.class]) {
            NSDate *date = value;
            sqlite3_bind_double(stmt, i, date.timeIntervalSinceReferenceDate);
        } else {
            @throw wfdao_exception(self, @"Bind argument failed. Entity: '%@', Property: '%@'.", NSStringFromClass([obj class]), name);
        }
    }
}
-(BOOL)statement:(sqlite3_stmt *)stmt bindParameterAtIndex:(int)index withArgument:(void *)pArgument type:(const char *)type{
    char t = type[0];
    if (t == _C_ID) {
        id obj = *((__unsafe_unretained id *)(void *)pArgument);
        if (obj == nil) {
            sqlite3_bind_null(stmt, index);
        } else if ([obj isKindOfClass:NSString.class]) {
            NSString *value = *((__unsafe_unretained id *)(void *)pArgument);
            sqlite3_bind_text(stmt, index, value.UTF8String, (int)value.length, SQLITE_STATIC);
        } else if ([obj isKindOfClass:NSDate.class]) {
            NSDate *value = *((__unsafe_unretained id *)(void *)pArgument);
            sqlite3_bind_double(stmt, index, value.timeIntervalSinceReferenceDate);
        } else {
            return NO;
        }
    } else {
        switch (t) {
            case _C_LNG_LNG:
                sqlite3_bind_int64(stmt, index, *(int64_t *)pArgument);
                break;
            case _C_BOOL:
                sqlite3_bind_int64(stmt, index, *(unsigned char *)pArgument);
                break;
            case _C_DBL:
                sqlite3_bind_double(stmt, index, *(double *)pArgument);
                break;
            default:
                return NO;
        }
    }
    return YES;
}
@end
