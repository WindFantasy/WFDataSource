//
//  Application.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "EmployeeService.h"
#import "ProjectService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Application : NSObject
@property (nonatomic, readonly, class) Application *sharedInstance;

@property (nonatomic, readonly) id<EmployeeService> employee;
@property (nonatomic, readonly) id<ProjectService> project;
@end

NS_ASSUME_NONNULL_END

#define APP Application.sharedInstance
