//
//  AppDataTableViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "AppDataTableViewController.h"
#import "AppDataTableViewCell.h"

@interface AppDataTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation AppDataTableViewController
-(void)setData:(NSArray *)data{
    _data = data;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.data = self.data[indexPath.row];
    if (self.separateRowColor) {
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor : [UIColor colorNamed:@"TableRow"];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.separateRowColor) {
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor : [UIColor colorNamed:@"TableRow"];
    }
}
@end
