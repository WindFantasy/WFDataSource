//
//  ValueObjectA.h
//  WFDataSourceTests
//
//  Created by Jerry on 2020/1/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ValueObjectA : NSObject
@property (nonatomic, copy) NSData *text;
@property (nonatomic, assign) float decimal;
@property (nonatomic, readonly, assign) NSInteger readonlyValue;
@property (nonatomic, copy) NSNumber *numberObject;
@end

NS_ASSUME_NONNULL_END
