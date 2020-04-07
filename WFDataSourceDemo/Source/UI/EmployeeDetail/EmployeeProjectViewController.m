//
//  EmployeeProjectViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/3.
//

#import "EmployeeProjectViewController.h"

@interface EmployeeProjectViewController ()

@end

@implementation EmployeeProjectViewController
-(void)setEmployee:(id<Employee>)employee{
    _employee = employee;
    self.data = self.employee.projects;
}
@end
