//
//  WFAttributeRestriction.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WFAttributeType) {
    WFStringAttribute,
    WFBooleanAttribute,
};

@interface WFXAttributeValidator : NSObject
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) WFAttributeType type;
@property (nonatomic, assign, readonly) BOOL required;

+(instancetype)attributeValidatorWithName:(NSString *)name type:(WFAttributeType)type required:(BOOL)required;
@end

NS_ASSUME_NONNULL_END
