//
//  WFDSUpdate.m
//  WFDataSource
//
//  Created by Jerry on 2020/1/3.
//  Copyright © 2020 Wind Fant. All rights reserved.
//

#import "WFDSUpdate.h"
#import "wfdao.h"
#import <objc/runtime.h>
#import "WFDSConnection+Internal.h"
#import "WFDSOperation+Internal.h"

@implementation WFDSUpdate
+(NSString *)buildSqlWithOperation:(WFDSUpdate *)operation{
    NSSet<NSString *> *labels = [self connection:operation.dao.connection columnLabelsForTable:operation.definition.table exclude:operation.definition.exclude];
    if (labels.count == 0) {
        @throw wfdao_exception(operation, @"Build sql failed. Should include at less 1 column.");
    }
    
    NSMutableArray<NSString *> *tokens = [NSMutableArray array];
    for (NSString *l in labels) {
        NSString *p = wfds_toCamel(l.UTF8String);
        p = [@":" stringByAppendingString:p];
        NSString *t = [NSString stringWithFormat:@"%@=%@", l, p];
        [tokens addObject:t];
    }
    NSString *sets = [tokens componentsJoinedByString:@", "];
    return [NSString stringWithFormat:@"UPDATE %@ SET \n%@ \nWHERE %@", operation.definition.table, sets, operation.definition.where];
}
-(instancetype)initWithElement:(id<WFDSScriptAccess>)element{
    self = [super initWithElement:element];
    if (self) {
        self.definition.table = element.table;
        self.definition.exclude = element.exclude;
        self.definition.where = element.where;
    }
    return self;
}
-(void)performInvocation:(NSInvocation *)invocation{
    if (self.definition.sql.length == 0) {
        self.definition.sql = [WFDSUpdate buildSqlWithOperation:self];
        wfdao_infoA(self, @"Build statement. \n%@", self.definition.sql);
    }
    [super performInvocation:invocation];
}
@end
