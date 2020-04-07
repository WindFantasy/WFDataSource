//
//  EmployeeDetailViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/3.
//

#import "EmployeeDetailViewController.h"

@protocol EmployeeAccessible <NSObject>
@property (nonatomic, strong) id<Employee> employee;
@end

@implementation EmployeeDetailViewController
-(void)didPresentViewController:(UIViewController<EmployeeAccessible> *)childViewController{
    childViewController.employee = (id)self.employee;
}
@end
