//
//  EmployeeDao.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "EmployeeEntity.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EmployeeDao <NSObject>
-(NSInteger)insert:(EmployeeEntity *)entity;
-(NSInteger)update:(EmployeeEntity *)entity;
-(NSString *)selectLatestEid;
-(NSArray<EmployeeEntity *> *)selectAll;
-(NSArray<EmployeeEntity *> *)selectEmployeesWithPid:(NSString *)pid;
@end

NS_ASSUME_NONNULL_END
