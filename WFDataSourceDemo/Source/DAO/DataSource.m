//
//  DataSource.m
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "DataSource.h"

@implementation DataSource
@synthesize connection=_connection;
@synthesize employee=_employee;
@synthesize project=_project;
+(DataSource *)sharedInstance{
    static id INSTANCE;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[DataSource alloc] init];
    });
    return INSTANCE;
}
- (WFDSConnection *)connection{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _connection = [WFDSConnection connectionWithDocumentPath:@"main.sqlite"];
        [_connection processSQLStreamInMainBundle];
    });
    return _connection;
}
-(id<EmployeeDao>)employee{
    if (!_employee) {
        _employee = [WFDSDaoManager.sharedManager instantiateDaoWithConnection:self.connection script:@"employee" protocol:@protocol(EmployeeDao)];
    }
    return _employee;
}
-(id<ProjectDao>)project{
    if (!_project) {
        _project = [WFDSDaoManager.sharedManager instantiateDaoWithConnection:self.connection script:@"project" protocol:@protocol(ProjectDao)];
    }
    return _project;
}
@end
