//
//  Employee.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Employee <NSObject>
@property (nonatomic, readonly, copy) NSString *eid;
@property (nonatomic, readonly, copy) NSString *firstName;
@property (nonatomic, readonly, copy) NSString *lastName;
@property (nonatomic, readonly, copy) NSDate *dob;
@property (nonatomic, readonly, copy) NSString *gender;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, assign) double salary;

@property (nonatomic, readonly, copy) NSString *fullName;

-(NSArray<id<Project>> *)projects;
-(void)save;
@end


@protocol EditableEmployee <Employee>
@property (nonatomic, readwrite, copy) NSString *firstName;
@property (nonatomic, readwrite, copy) NSString *lastName;
@property (nonatomic, readwrite, copy) NSDate *dob;
@property (nonatomic, readwrite, copy) NSString *gender;
@end

NS_ASSUME_NONNULL_END
