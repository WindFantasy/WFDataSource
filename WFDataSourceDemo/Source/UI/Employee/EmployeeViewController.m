//
//  EmployeeViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "EmployeeViewController.h"
#import "Application.h"
#import "EmployeeDetailViewController.h"
#import "EmployeeEditorTableViewController.h"

@implementation EmployeeViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Show Detail"]) {
        EmployeeDetailViewController *viewController = (id)segue.destinationViewController;
        viewController.employee = self.data[self.tableView.indexPathForSelectedRow.row];
    } else if ([segue.identifier isEqualToString:@"Show Add"]){
        EmployeeEditorTableViewController *viewController = (id)segue.destinationViewController;
        viewController.employee = [APP.employee prepareNewEmployee];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.data = APP.employee.employees;
}
@end
