//
//  EmployeeService.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EmployeeService <NSObject>
@property (nonatomic, readonly, copy) NSArray<id<Employee>> *employees;
-(id<EditableEmployee>)prepareNewEmployee;
-(NSArray<id<Employee>> *)employeesWithPid:(NSString *)pid;
@end

NS_ASSUME_NONNULL_END
