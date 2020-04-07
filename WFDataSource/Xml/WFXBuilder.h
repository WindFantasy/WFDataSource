//
//  WFXBuilder.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFXValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFXBuilder : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL mixed;

+(instancetype)builder;
-(void)addBooleanAttribute:(NSString *)name required:(BOOL)required;
-(void)addStringAttribute:(NSString *)name required:(BOOL)required;
-(id<WFXValidator>)build;
@end

NS_ASSUME_NONNULL_END
