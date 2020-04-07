//
//  EmployeeImpl.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "EmployeeImpl.h"
#import "EmployeeEntity.h"
#import "DataSource.h"
#import "EmployeeServiceImpl.h"
#import "Application.h"

@interface EmployeeImpl()
@property (nonatomic, readonly, strong) EmployeeEntity *target;
@end

@implementation EmployeeImpl
@synthesize fullName=_fullName;
@synthesize gender=_gender;
@dynamic firstName;
@dynamic lastName;
@dynamic target;
@dynamic eid;
@dynamic position;
@dynamic salary;
@dynamic dob;

- (instancetype)initWithTarget:(EmployeeEntity *)target{
    self = [super initWithTarget:target];
    if (self) {
        _fullName = [NSString stringWithFormat:@"%@, %@", self.target.firstName, self.target.lastName];
        _gender = self.target.gender == 0 ? @"Female" : @"Male";
        if (!target.eid) {
            _gender = nil;
        }
    }
    return self;
}
- (void)save{
    if (!self.target.eid) {
        NSString *latestEid = [DS.employee selectLatestEid];
        NSInteger num = [latestEid substringFromIndex:4].integerValue;
        NSString *eid = [NSString stringWithFormat:@"eid-%06ld", num];
        self.target.eid = eid;
    }
    self.target.gender = _gender.UTF8String[0] == 'M' ? 1 : 0;
    if([DS.employee update:self.target] != 1 && [DS.employee insert:self.target] != 1){
        NSAssert(NO, @"Save employee failed.");
    }
    [((EmployeeServiceImpl *)APP.employee) reload];
}
-(NSArray<id<Project>> *)projects{
    return [APP.project projectsWithEid:self.target.eid];
}
@end
