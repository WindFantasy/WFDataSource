//
//  Project.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Employee;

@protocol Project <NSObject>
@property (nonatomic, readonly, copy) NSString *pid;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *status;
@property (nonatomic, readonly, copy) NSString *priority;
@property (nonatomic, readonly, assign) double buget;
@property (nonatomic, readonly, copy) NSString *desc;

-(void)save;
-(NSArray<id<Employee>> *)members;
@end

@protocol EditableProject <Project>
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, copy) NSString *status;
@property (nonatomic, readwrite, copy) NSString *priority;
@property (nonatomic, readwrite, assign) double buget;
@property (nonatomic, readwrite, copy) NSString *desc;
@end

NS_ASSUME_NONNULL_END
