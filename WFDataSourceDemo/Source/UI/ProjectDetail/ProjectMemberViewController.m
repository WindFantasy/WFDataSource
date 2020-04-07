//
//  ProjectMemberViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "ProjectMemberViewController.h"

@implementation ProjectMemberViewController

-(void)setProject:(id<Project>)project{
    _project = project;
    self.data = project.members;
}
@end
