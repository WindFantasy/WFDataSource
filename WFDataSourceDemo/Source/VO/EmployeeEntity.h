//
//  EmployeeEntity.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeEntity : NSObject
@property (nonatomic, copy) NSString *eid;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSDate *dob;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, assign) double salary;
@end

NS_ASSUME_NONNULL_END
