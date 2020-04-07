//
//  EmployeeInformationTableViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/3.
//

#import "EmployeeInformationTableViewController.h"

@interface EmployeeInformationTableViewController ()
@property (nonatomic, strong) IBOutlet UIBarButtonItem *itemDone;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *itemCompose;
@end

@implementation EmployeeInformationTableViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.parentViewController.navigationItem.rightBarButtonItem = nil;
}
-(void)setEditable:(BOOL)editable{
    [super setEditable:editable];
    self.parentViewController.navigationItem.rightBarButtonItem = editable ? self.itemDone : self.itemCompose;
}
-(IBAction)actionSetEditable:(id)sender{
    self.editable = YES;
    [self validate];
}
-(IBAction)actionSubmit:(id)sender{
    [self.view endEditing:YES];
    self.editable = NO;
    [self saveEmployeeValues];
}
@end
