//
//  WFDSInsert.m
//  WFDataSource
//
//  Created by Jerry on 2020/1/3.
//

#import "WFDSInsert.h"
#import "wfdao.h"
#import <objc/runtime.h>
#import "WFDSConnection+Internal.h"
#import "WFDSOperation+Internal.h"

@implementation WFDSInsert
+(NSString *)buildSqlWithOperation:(WFDSInsert *)operation{
    NSSet<NSString *> *labels = [self connection:operation.dao.connection columnLabelsForTable:operation.definition.table exclude:operation.definition.exclude];
    if (labels.count == 0) {
        @throw wfdao_exception(operation, @"Build sql failed. Should include at less 1 column.");
    }
    
    NSMutableArray<NSString *> *columns = [NSMutableArray array];
    NSMutableArray<NSString *> *properties = [NSMutableArray array];
    for (NSString *l in labels) {
        NSString *p = wfds_toCamel(l.UTF8String);
        p = [@":" stringByAppendingString:p];
        [columns addObject:l];
        [properties addObject:p];
    }
    NSString *cStatement = [columns componentsJoinedByString:@", "];
    NSString *pStatement = [properties componentsJoinedByString:@", "];
    return [NSString stringWithFormat:@"INSERT INTO %@ (%@)\nVALUES (%@)", operation.definition.table, cStatement, pStatement];
}
-(instancetype)initWithElement:(id<WFDSScriptAccess>)element{
    self = [super initWithElement:element];
    if (self) {
        self.definition.table = element.table;
        self.definition.exclude = element.exclude;
    }
    return self;
}
-(void)performInvocation:(NSInvocation *)invocation{
    if (self.definition.sql.length == 0) {
        self.definition.sql = [WFDSInsert buildSqlWithOperation:self];
        wfdao_infoA(self, @"Build statement. \n%@", self.definition.sql);
    }
    [super performInvocation:invocation];
}
@end
