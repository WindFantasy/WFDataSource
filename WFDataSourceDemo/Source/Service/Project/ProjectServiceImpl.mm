//
//  ProjectServiceImpl.mm
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import "ProjectServiceImpl.h"
#import "DataSource.h"
#import "ProjectImpl.h"
#import <WFStream/WFStream.h>

@implementation ProjectServiceImpl
@synthesize projects=_projects;

- (instancetype)init{
    self = [super init];
    if (self) {
        [self reload];
    }
    return self;
}
-(void)reload{
    _projects = [DS.project selectAll].stream
    .map(^id _Nullable(__unsafe_unretained ProjectEntity * _Nonnull e) {
        return [[ProjectImpl alloc] initWithTarget:e];
    }).array();
}
-(id<EditableProject>)prepareNewProject{
    ProjectEntity *entity = [[ProjectEntity alloc] init];
    entity.status = @"P";
    return [[ProjectImpl alloc] initWithTarget:entity];
}
-(NSArray<id<Project>> *)projectsWithEid:(NSString *)eid{
    return [DS.project selectProjectsWithEid:eid].stream
    .map(^id _Nullable(__unsafe_unretained ProjectEntity * _Nonnull e) {
        return [[ProjectImpl alloc] initWithTarget:e];
    }).array();
}
@end
