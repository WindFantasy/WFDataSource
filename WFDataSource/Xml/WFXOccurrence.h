//
//  WFXValidatorSettings.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WFXElementValidator;

@interface WFXOccurrence : NSObject
@property (nonatomic, strong) WFXElementValidator *validator;
@end

NS_ASSUME_NONNULL_END
