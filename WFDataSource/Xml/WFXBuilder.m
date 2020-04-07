//
//  WFXBuilder.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import "WFXBuilder.h"
#import "WFXElementValidator.h"
#import "WFXAttributeValidator.h"

@implementation WFXBuilder{
    NSMutableDictionary<NSString *, WFXAttributeValidator *> *_attributes;
}
+(instancetype)builder{
    return [[self alloc] init];
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _attributes = [NSMutableDictionary dictionary];
    }
    return self;
}
-(void)addBooleanAttribute:(NSString *)name required:(BOOL)required{
    _attributes[name] = [WFXAttributeValidator attributeValidatorWithName:name type:WFBooleanAttribute required:required];
}
-(void)addStringAttribute:(NSString *)name required:(BOOL)required{
    _attributes[name] = [WFXAttributeValidator attributeValidatorWithName:name type:WFStringAttribute required:required];
}
-(id<WFXValidator>)build{
    WFXElementValidator *validator = [[WFXElementValidator alloc] init];
    validator.name = self.name;
    validator.mixed = self.mixed;
    validator.attributes = _attributes;
    return validator;
}
@end
