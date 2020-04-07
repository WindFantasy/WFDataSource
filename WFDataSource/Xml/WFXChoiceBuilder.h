//
//  WFXChoiceBuilder.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFXBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@class WFXElementValidator;

@interface WFXChoiceBuilder : WFXBuilder
-(void)addChoice:(WFXElementValidator *)validator;
@end

NS_ASSUME_NONNULL_END
