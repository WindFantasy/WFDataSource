//
//  ProjectImpl.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "ProjectImpl.h"
#import "ProjectEntity.h"
#import "DataSource.h"
#import "Application.h"
#import "ProjectServiceImpl.h"

@interface ProjectImpl()
@property (nonatomic, readonly, strong) ProjectEntity *target;
@end

@implementation ProjectImpl
@dynamic target;
@dynamic pid;
@dynamic buget;
@dynamic name;
@dynamic desc;
@dynamic status;
@synthesize priority=_priority;

-(instancetype)initWithTarget:(ProjectEntity *)target{
    self = [super initWithTarget:target];
    if (self) {
        static NSString * const PRIORITIES[] = {
            [1] = @"High",
            [2] = @"Middium",
            [3] = @"Low",
        };
        _priority = PRIORITIES[target.priority];
    }
    return self;
}
-(void)save{
    static NSInteger PRIORITIES[] = {
        ['H'] = 1,
        ['M'] = 2,
        ['L'] = 3,
    };
    if (!self.target.pid) {
        NSString *latestEid = [DS.project selectLatestPid];
        NSInteger num = [latestEid substringFromIndex:4].integerValue;
        NSString *pid = [NSString stringWithFormat:@"eid-%06ld", num];
        self.target.pid = pid;
    }
    self.target.priority = PRIORITIES[_priority.UTF8String[0]];
    
    if([DS.project update:self.target] != 1 && [DS.project insert:self.target] != 1){
        NSAssert(NO, @"Save project failed.");
    }
    
    [((ProjectServiceImpl *)APP.project) reload];
}
-(NSArray<id<Employee>> *)members{
    return [APP.employee employeesWithPid:self.target.pid];
}
@end
