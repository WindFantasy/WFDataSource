//
//  WFXGeneralElement.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFXGeneralElement.h"
#import "WFXElementValidator.h"
#import "wfds.h"
#import <objc/runtime.h>

@implementation WFXGeneralElement{
    NSMutableArray<WFXGeneralElement *> *_children;
    __weak WFXGeneralElement *_parent;
    NSMutableDictionary<NSString *, NSMutableArray<WFXGeneralElement *>*> *_childDictionary;
    NSMutableDictionary<NSString *, id> *_attributeDictionary;
    id _obj;
    BOOL _b;
}
@synthesize children=_children;
@synthesize level=_level;
@synthesize parent=_parent;
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString * name = NSStringFromSelector(aSelector);
    WFXAttributeValidator *attributeValidator = _validator.attributes[name];
    if (attributeValidator != nil) {
        static const char *SIGNATURES[] = {
            [WFStringAttribute] = "@:@",
            [WFBooleanAttribute] = "B:@",
        };
        return [NSMethodSignature signatureWithObjCTypes:SIGNATURES[attributeValidator.type]];
    }
    return nil;
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    NSString * name = NSStringFromSelector(anInvocation.selector);
    _obj = _attributeDictionary[name];
    if (_obj) {
        WFXAttributeValidator *attributeValidator = _validator.attributes[name];
        if (attributeValidator.type == WFBooleanAttribute) {
            _b = [_obj boolValue];
            [anInvocation setReturnValue:&_b];
        } else{
            [anInvocation setReturnValue:&_obj];
        }
        return;
    }
    _obj = nil;
    [anInvocation setReturnValue:&_obj];
    return;
}
-(instancetype)initWithValidator:(WFXElementValidator *)validator{
    self = [super init];
    if (self) {
        _validator = validator;
        _children = [NSMutableArray array];
        _childDictionary = [NSMutableDictionary dictionary];
        _attributeDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}
-(NSString *)name{
    return _validator.name;
}
-(void)addChild:(WFXGeneralElement *)child{
    child->_parent = self;
    child->_level = _level + 1;
    [_children addObject:child];
    [[self childrenForName:child.name] addObject:child];
}
-(NSMutableArray *)childrenForName:(NSString *)name{
    id array = _childDictionary[name];
    if (!array) {
        _childDictionary[name] = array = [NSMutableArray array];
    }
    return array;
}
-(void)attribute:(NSString *)attributeName setString:(NSString *)value{
    _attributeDictionary[attributeName] = value;
}
-(void)attribute:(NSString *)attributeName setBoolean:(BOOL)value{
    _attributeDictionary[attributeName] = @(value);
}
@end
