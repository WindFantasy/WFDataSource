//
//  BasicValueObject.h
//  WFDataSourceTests
//
//  Created by Jerry on 2019/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicValueObject : NSObject
@property (nonatomic, copy, nullable) NSString *identity;

@property (nonatomic, assign) BOOL booleanValue;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) double decimal;
@property (nonatomic, copy, nullable) NSString *text;
@property (nonatomic, copy, nullable) NSDate *date;
@end

NS_ASSUME_NONNULL_END
