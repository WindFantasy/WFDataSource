//
//  ProjectEditorTableViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/1.
//

#import "ProjectEditorTableViewController.h"
#import "AppButton.h"
#import "AppCurrencyField.h"
#import "Utility.h"

@interface ProjectEditorTableViewController ()
@property (nonatomic, weak) IBOutlet UITextField *fieldId;
@property (nonatomic, weak) IBOutlet UITextField *fieldName;
@property (nonatomic, weak) IBOutlet AppButton *buttonStatus;
@property (nonatomic, weak) IBOutlet AppButton *buttonPriority;
@property (nonatomic, weak) IBOutlet AppCurrencyField *fieldBuget;
@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *itemDone;
@end

@implementation ProjectEditorTableViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.textView.layer.cornerRadius = 8.0f;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.project = self.project;
    [self validate];
}
-(void)setProject:(id<EditableProject>)project{
    _project = project;
    self.fieldId.text = project.pid;
    self.fieldName.text = project.name;
    
    self.buttonStatus.theTitle = project.status;
    self.buttonPriority.theTitle = project.priority;
    self.fieldBuget.currency = project.buget;
    self.textView.text = project.desc;
}
-(void)validate{
    BOOL a = self.fieldName.text.length == 0 ||
    self.buttonPriority.theTitle.length == 0 ||
    self.fieldBuget.text.length == 0;
    self.itemDone.enabled = !a;
}
-(void)saveProjectValues{
    self.project.name = self.fieldName.text;
    self.project.status = self.buttonStatus.theTitle;
    self.project.priority = self.buttonPriority.theTitle;
    self.project.buget = [self.fieldBuget.text substringFromIndex:1].doubleValue;
    self.project.desc = self.textView.text;
    [self.project save];
}
#pragma mark - Actions
-(IBAction)actionSwitchPriorityOptions:(id)sender{
    static NSString * const VALUES[] = {@"High", @"Middium", @"Low"};
    self.buttonPriority.theTitle = SwitchValues(VALUES, 3, self.buttonPriority.theTitle);
    [self validate];
}
-(IBAction)actionValidate:(id)sender{
    [self validate];
}
-(IBAction)actionSubmit:(id)sender{
    [self.view endEditing:YES];
    [self saveProjectValues];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
