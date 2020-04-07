//
//  WFXBuilder.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "WFXValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFXBuilder : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL mixed;

+(instancetype)builder;
-(void)addBooleanAttribute:(NSString *)name required:(BOOL)required;
-(void)addStringAttribute:(NSString *)name required:(BOOL)required;
-(id<WFXValidator>)build;
@end

NS_ASSUME_NONNULL_END
