//
//  ProjectDetailViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "ProjectDetailViewController.h"

@protocol ProjectAccessible <NSObject>
@property (nonatomic, strong) id<Project> project;
@end

@implementation ProjectDetailViewController
-(void)didPresentViewController:(UIViewController<ProjectAccessible> *)childViewController{
    childViewController.project = (id)self.project;
}
@end
