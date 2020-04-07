//
//  Application.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "Application.h"
#import "EmployeeServiceImpl.h"
#import "ProjectServiceImpl.h"

@implementation Application
@synthesize employee=_employee;
@synthesize project=_project;
+(Application *)sharedInstance{
    static id INSTANCE;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[Application alloc] init];
    });
    return INSTANCE;
}
-(id<EmployeeService>)employee{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _employee = [[EmployeeServiceImpl alloc] init];
    });
    return _employee;
}
-(id<ProjectService>)project{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _project = [[ProjectServiceImpl alloc] init];
    });
    return _project;
}
@end
