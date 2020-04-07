//
//  ProjectEditorTableViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/1.
//

#import <UIKit/UIKit.h>
#import "AppStaticFormTableViewController.h"
#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectEditorTableViewController : AppStaticFormTableViewController
@property (nonatomic, strong) id<EditableProject> project;

-(void)saveProjectValues;
-(void)validate;
@end

NS_ASSUME_NONNULL_END
