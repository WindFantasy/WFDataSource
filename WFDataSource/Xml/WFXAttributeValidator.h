//
//  WFAttributeRestriction.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WFAttributeType) {
    WFStringAttribute,
    WFBooleanAttribute,
};

@interface WFXAttributeValidator : NSObject
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, assign) WFAttributeType type;
@property (nonatomic, readonly, assign) BOOL required;

+(instancetype)attributeValidatorWithName:(NSString *)name type:(WFAttributeType)type required:(BOOL)required;
@end

NS_ASSUME_NONNULL_END
