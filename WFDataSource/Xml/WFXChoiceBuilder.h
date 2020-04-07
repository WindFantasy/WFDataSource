//
//  WFXChoiceBuilder.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "WFXBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@class WFXElementValidator;

@interface WFXChoiceBuilder : WFXBuilder
-(void)addChoice:(WFXElementValidator *)validator;
@end

NS_ASSUME_NONNULL_END
