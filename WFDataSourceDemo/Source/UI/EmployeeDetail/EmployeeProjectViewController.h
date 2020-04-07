//
//  EmployeeProjectViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/3.
//

#import "AppDataTableViewController.h"
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeProjectViewController : AppDataTableViewController
@property (nonatomic, strong) id<Employee> employee;
@end

NS_ASSUME_NONNULL_END
