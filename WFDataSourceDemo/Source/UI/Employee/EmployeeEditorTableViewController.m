//
//  EmployeeEditorTableViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/1.
//

#import "EmployeeEditorTableViewController.h"
#import "AppCurrencyField.h"
#import "AppButton.h"
#import "AppDateField.h"
#import "Utility.h"

@interface EmployeeEditorTableViewController ()
@property (nonatomic, weak) IBOutlet UITextField *fieldId;
@property (nonatomic, weak) IBOutlet UITextField *fieldFirstName;
@property (nonatomic, weak) IBOutlet UITextField *fieldLastName;
@property (nonatomic, weak) IBOutlet AppDateField *fieldDob;
@property (nonatomic, weak) IBOutlet AppButton *buttonGender;
@property (nonatomic, weak) IBOutlet AppButton *buttonPosition;
@property (nonatomic, weak) IBOutlet AppCurrencyField *fieldSalary;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *itemDone;
@end

@implementation EmployeeEditorTableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.employee = self.employee;
    [self validate];
}
-(void)setEmployee:(id<EditableEmployee>)employee{
    _employee = employee;
    self.fieldId.text = employee.eid;
    self.fieldFirstName.text = employee.firstName;
    self.fieldLastName.text = employee.lastName;
    self.fieldDob.date = employee.dob;
    self.buttonGender.theTitle = employee.gender;
    self.buttonPosition.theTitle = employee.position;
    self.fieldSalary.currency = employee.salary;
}
-(void)validate{
    BOOL a = self.fieldFirstName.text.length == 0 ||
    self.fieldLastName.text.length == 0 ||
    self.fieldDob.text.length == 0 ||
    self.buttonGender.theTitle.length == 0 ||
    self.buttonPosition.theTitle.length == 0 ||
    self.fieldSalary.text.length == 0;
    
    self.itemDone.enabled = !a;
}
-(void)button:(UIButton *)button setTitle:(NSString *)title{
    [button setTitle:title forState:UIControlStateNormal];
}
-(void)saveEmployeeValues{
    self.employee.firstName = self.fieldFirstName.text;
    self.employee.lastName = self.fieldLastName.text;
    self.employee.dob = self.fieldDob.date;
    self.employee.gender = self.buttonGender.theTitle;
    self.employee.position = self.buttonPosition.theTitle;
    self.employee.salary = self.fieldSalary.currency;
    [self.employee save];
}
#pragma mark - Actions
-(IBAction)actionSwitchGender:(id)sender{
    static NSString *const VALUES[] = {@"Male", @"Female"};
    self.buttonGender.theTitle = SwitchValues(VALUES, 2, self.buttonGender.theTitle);
    [self validate];
}
-(IBAction)actionPresentPositionOptions:(id)sender{
    NSArray *titles = @[@"iOS Developer",
                        @"JAVA Developer",
                        @"HR Manager",
                        @"Chief Technical Officer"];
    UIAlertController *alertController = MakeActionSheet(@"Employee Position",
                                                         @"Please select the position of '%@'.", self.employee.fullName);
    SetupAlertActions(alertController, titles, @"Cancel", ^(UIAlertAction * _Nonnull action) {
        [self.buttonPosition setTitle:action.title forState:UIControlStateNormal];
        [self validate];
    });
    [self presentViewController:alertController animated:YES completion:nil];
}
-(IBAction)actionValidate:(id)sender{
    [self validate];
}
-(IBAction)actionSubmit:(id)sender{
    [self.view endEditing:YES];
    [self saveEmployeeValues];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
