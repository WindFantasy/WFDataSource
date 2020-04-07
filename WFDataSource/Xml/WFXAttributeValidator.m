//
//  WFAttributeRestriction.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFXAttributeValidator.h"

@implementation WFXAttributeValidator
+(instancetype)attributeValidatorWithName:(NSString *)name type:(WFAttributeType)type required:(BOOL)required{
    WFXAttributeValidator *attribute = [[WFXAttributeValidator alloc] init];
    attribute->_name = name;
    attribute->_type = type;
    attribute->_required = required;
    return attribute;
}
@end
