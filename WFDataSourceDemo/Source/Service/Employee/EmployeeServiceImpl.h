//
//  EmployeeServiceImpl.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "EmployeeService.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeServiceImpl : NSObject<EmployeeService>
-(void)reload;
@end

NS_ASSUME_NONNULL_END
