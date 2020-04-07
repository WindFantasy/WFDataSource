//
//  ProjectViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/27.
//

#import "ProjectViewController.h"
#import "Application.h"
#import "ProjectEditorTableViewController.h"
#import "ProjectDetailViewController.h"

@implementation ProjectViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Show Add"]) {
        ProjectEditorTableViewController *viewController = (id)segue.destinationViewController;
        viewController.project = [APP.project prepareNewProject];
    } else if ([segue.identifier isEqualToString:@"Show Detail"]) {
        ProjectDetailViewController *viewController = (id)segue.destinationViewController;
        viewController.project = self.data[self.tableView.indexPathForSelectedRow.row];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.data = APP.project.projects;
}
@end
