//
//  ProjectTableViewCell.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/27.
//

#import "ProjectTableViewCell.h"
#import "Project.h"

@interface ProjectTableViewCell()
@property (nonatomic, weak) IBOutlet UILabel *labelName;
@property (nonatomic, weak) IBOutlet UILabel *labelPriority;
@property (nonatomic, weak) IBOutlet UILabel *labelBuget;
@property (nonatomic, weak) IBOutlet UILabel *labelStatus;
@end

@implementation ProjectTableViewCell
-(void)setData:(id<Project>)data{
    [super setData:data];
    self.labelName.text = data.name;
    self.labelPriority.text = data.priority;
    self.labelBuget.text = [NSString stringWithFormat:@"Buget: $%0.2f", data.buget];
    self.labelStatus.text = data.status;
}
@end
