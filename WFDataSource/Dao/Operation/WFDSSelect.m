//
//  WFDSSelect.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFDSSelect.h"
#import <objc/runtime.h>
#import "WFDSConnection.h"
#import "wfdao.h"
#import "WFDSConnection+Internal.h"
#import "WFDSEntityHints+Internal.h"

id wfdao_converRowToObject(WFDSResultSet *resultSet, sqlite3_stmt *stmt, WFDSEntityHints *hints);

/**
 The main process of a WFSelectOperation is to convert the result set to an 'invocation-return'.
 
 The convertion will result in 3 types of return value:
 
 - Primary types (BOOL, NSInteger, double)

 - Compatible objects (NSString and NSDate)

 - Entity objects (value objects) or an array of entity objects.
 
 An entity obejct is a custom defined class instance that its properties are referred to columns of a query.
 */
@implementation WFDSSelect{
    BOOL _b;
    int64_t _i;
    double _d;
    id _o;
}
-(instancetype)initWithElement:(id<WFDSScriptAccess>)element{
    self = [super initWithElement:element];
    if (self) {
        NSString *targetClass = element.type;
        if (targetClass.length > 0) {
            WFDSEntityHints *hints = [[WFDSEntityHints alloc] init];
            if ([targetClass hasPrefix:@"@"]) {
                hints.singleTarget = YES;
                targetClass = [targetClass substringFromIndex:1];
            }
            hints.targetClass = NSClassFromString(targetClass);
            if (!hints.targetClass) {
                @throw wfdao_exception(nil, @"Class '%@' not found.", targetClass);
            }
            self.definition.hints = hints;
        }
    }
    return self;
}
-(void)performInvocation:(NSInvocation *)invocation{
    WFDSStatement *statement = [self.dao.connection prepareStatement:self.definition.sql];
    WFDSResultSet *resultSet;
    @try {
        [self statement:statement bindParametersWithArgumentsFromInvocation:invocation];
        resultSet = [statement executeQuery];
        char c = [[invocation methodSignature] methodReturnType][0];
        if (c == _C_ID) {
            WFDSEntityHints *hints = self.definition.hints;
            if (!hints) {   // Convert to compatible objects
                _o = [self convertResultSetToCompatibleObject:resultSet];
            } else {    // Convert to entity objects
                _o = [self convertResultSet:resultSet toEntityObjectWithHints:hints];
            }
            [invocation setReturnValue:&_o];
        } else{ // Convert to primary types
            [resultSet next];
            switch (c) {
                case _C_LNG_LNG:
                    _i = [resultSet integerForColumnAtIndex:0];
                    [invocation setReturnValue:&_i];
                    break;
                case _C_BOOL:
                    _b = [resultSet integerForColumnAtIndex:0];
                    [invocation setReturnValue:&_b];
                    break;
                case _C_DBL:
                    _d = [resultSet doubleForColumnAtIndex:0];
                    [invocation setReturnValue:&_d];
                    break;
                default:
                    @throw wfdao_exception(self, @"Unexpected return type.");
                    break;
            }
        }
    } @catch (NSException *exception) {
        @throw exception;
    } @finally {
        if (resultSet) {
            [resultSet close];
        }
        [statement close];
    }
}
-(id)convertResultSetToCompatibleObject:(WFDSResultSet *)resultSet {
    sqlite3_stmt *stmt = resultSet.statement.stmt;
    if(![resultSet next]){
        @throw wfdao_exception(self, @"The query returns nothing.");
        return nil;
    }
    if (resultSet.numColumn != 1) {
        @throw wfdao_exception(self, @"Conversion failed. Too many columns (%d).", resultSet.numColumn);
    }
    int type = sqlite3_column_type(stmt, 0);
    if (type == SQLITE3_TEXT) {
        const void *bytes = sqlite3_column_text(stmt, 0);
        return @((const char *)bytes);
    } else if (type == SQLITE_FLOAT) {
        double value = sqlite3_column_double(stmt, 0);
        return [NSDate dateWithTimeIntervalSinceReferenceDate:value];
    } else if (type == SQLITE_NULL) {
        return nil;
    }
    @throw wfdao_exception(self, @"Conversion failed. Incompatible column type (type code: %d).", type);
    return nil;
}
-(id)convertResultSet:(WFDSResultSet *)resultSet toEntityObjectWithHints:(WFDSEntityHints *)hints{
    if (!hints->_prepared) {
        [self prepareHints:self.definition.hints withResultSet:resultSet];
    }

    if (hints.singleTarget) {   // Convert to 1 entity object
        if ([resultSet next]) {
            return wfdao_converRowToObject(resultSet, resultSet.statement.stmt, hints);
        }
        return nil;
    }
    
    // Convert to an array of entity objects
    NSMutableArray *array = [NSMutableArray array];
    while ([resultSet next]) {
        id obj = wfdao_converRowToObject(resultSet, resultSet.statement.stmt, hints);
        [array addObject:obj];
    }
    return array;
}
-(void)prepareHints:(WFDSEntityHints *)hints withResultSet:(WFDSResultSet *)resultSet{
    sqlite3_stmt *stmt = resultSet.statement.stmt;
    
    NSMutableArray<WFDSColumn *> *columns = [NSMutableArray array];
    NSMutableSet<NSString *> *names = [NSMutableSet set];
    int count = sqlite3_column_count(stmt);
    for (int i = 0; i < count; i++) {
        const char *buf = sqlite3_column_name(stmt, i);
        NSString *name = wfds_toCamel(buf);
        if ([names containsObject:name]) {  // The later repeated labels are ignored
            continue;
        }
        objc_property_t p = class_getProperty(hints.targetClass, name.UTF8String);
        if (!p) {   // Ignore the column if the referred property not exist
            continue;
        }
        char *v = property_copyAttributeValue(p, "R");
        if (v) {    // Ignore the column if the referred property readonly
            free(v);
            continue;
        }
        // Set up type of the referred property.
        v = property_copyAttributeValue(p, "T");
        NSAssert(v != NULL, @"Access property type failed.");
        WFDSColumn *c = [[WFDSColumn alloc] init];
        switch (v[0]) {
            case _C_ID:{
                NSString *value = @(v);
                value = [value substringWithRange:NSMakeRange(2, value.length - 3)];
                if ([value isEqualToString:@"NSString"]) {
                    c.type = WFPropertyText;
                } else if ([value isEqualToString:@"NSDate"]) {
                    c.type = WFPropertyDate;
                } else {
                    @throw wfdao_exception(self, @"Incompatible property type '%@'.", value);
                }
                break;
            }
            case _C_LNG_LNG:
                c.type = WFPropertyInteger;
                break;
            case _C_BOOL:
                c.type = WFPropertyBoolean;
                break;
            case _C_DBL:
                c.type = WFPropertyFloat;
                break;
            default:
                @throw wfdao_exception(self, @"Convert query failed. Incompatible property type '%s'.", v);
                break;
        }
        free(v);
        c.name = name;
        c.index = i;
        [columns addObject:c];
        [names addObject:name];
    }
    hints->_columns = columns;
    hints->_prepared = YES;
}
@end

id wfdao_converRowToObject(WFDSResultSet *resultSet, sqlite3_stmt *stmt, WFDSEntityHints *hints){
    id obj = [[hints.targetClass alloc] init];
    for (WFDSColumn *c in hints->_columns) {
        id v;
        switch (c.type) {
            case WFPropertyBoolean:
                v = @(sqlite3_column_int64(stmt, c.index) != 0);
                break;
            case WFPropertyInteger:
                v = @(sqlite3_column_int64(stmt, c.index));
                break;
            case WFPropertyFloat:
                v = @(sqlite3_column_double(stmt, c.index));
                break;
            case WFPropertyText:{
                if (sqlite3_column_type(stmt, c.index) == SQLITE_NULL) {
                    break;
                }
                v = @((const char *)sqlite3_column_text(stmt, c.index));
                break;
            }
            case WFPropertyDate:
                if (sqlite3_column_type(stmt, c.index) == SQLITE_NULL) {
                    break;
                }
                v = [NSDate dateWithTimeIntervalSinceReferenceDate:sqlite3_column_double(stmt, c.index)];
                break;
        }
        [obj setValue:v forKey:c.name];
    }
    return obj;
}
