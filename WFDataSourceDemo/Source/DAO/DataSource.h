//
//  DataSource.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import <WFDataSource/WFDataSource.h>
#import "EmployeeDao.h"
#import "ProjectDao.h"


NS_ASSUME_NONNULL_BEGIN

@interface DataSource : NSObject
@property (nonatomic, readonly, class) DataSource *sharedInstance;
@property (nonatomic, readonly) WFDSConnection *connection;
@property (nonatomic, readonly) id<EmployeeDao> employee;
@property (nonatomic, readonly) id<ProjectDao> project;
@end

NS_ASSUME_NONNULL_END

#define DS DataSource.sharedInstance
