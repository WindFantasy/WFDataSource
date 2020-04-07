//
//  ProjectDetailViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import <UIKit/UIKit.h>
#import "AppPageViewController.h"
#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectDetailViewController : AppPageViewController
@property (nonatomic, strong) id<Project> project;
@end

NS_ASSUME_NONNULL_END
