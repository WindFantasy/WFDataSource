//
//  ProjectServiceImpl.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "ProjectService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectServiceImpl : NSObject<ProjectService>
-(void)reload;
@end

NS_ASSUME_NONNULL_END
