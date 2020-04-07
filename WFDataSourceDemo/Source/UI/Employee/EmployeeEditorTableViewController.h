//
//  EmployeeEditorTableViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/1.
//

#import <UIKit/UIKit.h>
#import "Employee.h"
#import "AppStaticFormTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeEditorTableViewController : AppStaticFormTableViewController
@property (nonatomic, strong) id<EditableEmployee> employee;

-(void)saveEmployeeValues;
-(void)validate;
@end

NS_ASSUME_NONNULL_END
