//
//  ProjectMemberViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "AppDataTableViewController.h"
#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectMemberViewController : AppDataTableViewController
@property (nonatomic, strong) id<Project> project;
@end

NS_ASSUME_NONNULL_END
