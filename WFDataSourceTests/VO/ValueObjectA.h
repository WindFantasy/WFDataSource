//
//  ValueObjectA.h
//  WFDataSourceTests
//
//  Created by Jerry on 2020/1/5.
//  Copyright © 2020 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ValueObjectA : NSObject
@property (nonatomic, strong) NSData *text;
@property (nonatomic, assign) float decimal;
@property (nonatomic, assign, readonly) NSInteger readonlyValue;
@property (nonatomic, strong) NSNumber *numberObject;
@end

NS_ASSUME_NONNULL_END
