//
//  EmployeeDetailViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/3.
//

#import "AppPageViewController.h"
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeDetailViewController : AppPageViewController
@property (nonatomic, strong) id<Employee> employee;
@end

NS_ASSUME_NONNULL_END
