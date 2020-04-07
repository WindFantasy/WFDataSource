//
//  ProjectService.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProjectService <NSObject>
@property (nonatomic, readonly, copy) NSArray<id<Project>> *projects;

-(id<EditableProject>)prepareNewProject;
-(NSArray<id<Project>> *)projectsWithEid:(NSString *)eid;
@end

NS_ASSUME_NONNULL_END
