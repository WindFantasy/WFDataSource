//
//  ProjectDao.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "ProjectEntity.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ProjectDao <NSObject>
-(NSInteger)insert:(ProjectEntity *)entity;
-(NSInteger)update:(ProjectEntity *)entity;
-(NSString *)selectLatestPid;
-(NSArray<ProjectEntity *> *)selectAll;
-(NSArray<ProjectEntity *> *)selectProjectsWithEid:(NSString *)eid;
@end

NS_ASSUME_NONNULL_END
