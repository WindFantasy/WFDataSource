//
//  EmployeeTableViewCell.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "EmployeeTableViewCell.h"
#import "Employee.h"

@interface EmployeeTableViewCell()
@property (nonatomic, weak) IBOutlet UILabel *labelFullName;
@property (nonatomic, weak) IBOutlet UILabel *labelPosition;
@property (nonatomic, weak) IBOutlet UILabel *labelGender;
@property (nonatomic, weak) IBOutlet UILabel *labelSalary;
@end

@implementation EmployeeTableViewCell
-(void)setData:(id<Employee>)data{
    [super setData:data];
    
    self.labelFullName.text = data.fullName;
    self.labelGender.text = data.gender;
    self.labelPosition.text = data.position;
    self.labelSalary.text = [NSString stringWithFormat:@"Salary: $%0.0f", data.salary];
}
@end
