//
//  ProjectEntity.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectEntity : NSObject
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) double buget;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) NSInteger priority;
@end

NS_ASSUME_NONNULL_END
