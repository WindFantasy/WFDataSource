//
//  EmployeeServiceImpl.mm
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "EmployeeServiceImpl.h"
#import "DataSource.h"
#import "EmployeeImpl.h"
#import <WFStream/WFStream.h>

@implementation EmployeeServiceImpl
@synthesize employees=_employees;

- (instancetype)init{
    self = [super init];
    if (self) {
        [self reload];
    }
    return self;
}
-(void)reload{
    _employees = [DS.employee selectAll].stream
    .map(^id _Nullable(__unsafe_unretained EmployeeEntity * _Nonnull e) {
        return [[EmployeeImpl alloc] initWithTarget:e];
    })
    .array();
}
-(id<Employee>)prepareNewEmployee{
    EmployeeEntity *entity = [[EmployeeEntity alloc] init];
    return [[EmployeeImpl alloc] initWithTarget:entity];
}
-(NSArray<id<Employee>> *)employeesWithPid:(NSString *)pid{
    return [DS.employee selectEmployeesWithPid:pid].stream
    .map(^id _Nullable(__unsafe_unretained EmployeeEntity * _Nonnull e) {
        return [[EmployeeImpl alloc] initWithTarget:e];
    })
    .array();
}
@end
