//
//  WFXGeneralElement.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "WFXElement.h"

NS_ASSUME_NONNULL_BEGIN

@class WFXElementValidator;

@interface WFXGeneralElement : NSObject<WFXElement>
@property (nonatomic, readonly) WFXElementValidator *validator;
@property (nonatomic, copy) NSString *value;

-(instancetype)initWithValidator:(WFXElementValidator *)validator;
-(void)addChild:(WFXGeneralElement *)child;
-(void)attribute:(NSString *)attributeName setString:(NSString *)value;
-(void)attribute:(NSString *)attributeName setBoolean:(BOOL)value;
@end

NS_ASSUME_NONNULL_END
