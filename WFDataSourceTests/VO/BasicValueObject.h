//
//  BasicValueObject.h
//  WFDataSourceTests
//
//  Created by Jerry on 2019/12/23.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicValueObject : NSObject
@property (nonatomic, nullable, strong) NSString *identity;

@property (nonatomic, assign) BOOL booleanValue;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) double decimal;
@property (nonatomic, nullable, strong) NSString *text;
@property (nonatomic, nullable, strong) NSDate *date;
@end

NS_ASSUME_NONNULL_END
