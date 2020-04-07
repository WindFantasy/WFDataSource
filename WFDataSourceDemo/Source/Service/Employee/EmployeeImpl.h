//
//  EmployeeImpl.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "Employee.h"
#import "Forwardable.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeImpl : Forwardable<EditableEmployee>

@end

NS_ASSUME_NONNULL_END
