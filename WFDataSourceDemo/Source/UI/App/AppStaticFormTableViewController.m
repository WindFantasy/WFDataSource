//
//  AppStaticFormTableViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "AppStaticFormTableViewController.h"
#import "AppButton.h"
#import "AppField.h"
#import "AppTextView.h"

@interface AppStaticFormTableViewController ()
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray<UIView *> *disabledFields;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray<UIView *> *editableFields;
@end

@implementation AppStaticFormTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionEndEditing:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.editable = self.editable;
}
-(void)refreshFields{
    for (UIView *v in self.disabledFields) {
        if ([v.class isSubclassOfClass:AppField.class]) {
            AppField *f = (id)v;
            f.enabled = NO;
        } else if ([v.class isSubclassOfClass:AppButton.class]){
            AppButton *b = (id)v;
            b.enabled = NO;
        }
    }
    BOOL editable = self.editable;
    for (UIView *v in self.editableFields) {
        if ([v.class isSubclassOfClass:AppField.class]) {
            AppField *f = (id)v;
            f.enabled = editable;
        } else if ([v.class isSubclassOfClass:AppButton.class]){
            AppButton *b = (id)v;
            b.enabled = editable;
        } else if ([v.class isSubclassOfClass:AppTextView.class]){
            AppTextView *t = (id)v;
            t.editable = editable;
        }
    }
}
-(void)setEditable:(BOOL)editable{
    _editable = editable;
    [self refreshFields];
}
-(void)actionEndEditing:(id)sender{
    [self.view endEditing:YES];
}
@end
