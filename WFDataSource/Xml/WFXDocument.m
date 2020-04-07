//
//  WFXDocument.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/7.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFXDocument.h"
#import "wfxsd.h"
#import "WFXElementValidator.h"

@interface WFXDocument()
@property (nonatomic, strong) WFXElementValidator *rootValidator;
@property (nonatomic, weak) WFXElementValidator *currentValidator;
@end

@implementation WFXDocument{
    NSMutableString *_mixedContent;
}
@synthesize parser=_parser;
-(instancetype)initWithValidator:(WFXElementValidator *)rootValidator parser:(WFXmlParser *)parser{
    self = [super init];
    if (self) {
        _currentValidator = _rootValidator = rootValidator;
        _parser = parser;
    }
    return self;
}
-(void)startElement:(NSString *)elementName{
    WFXGeneralElement *element;
    if (!_root) {
        if (![_rootValidator.name isEqualToString:elementName]) {
            @throw wfx_exception(_parser, @"Validation failed. Encounter unexpected element '%@'.", elementName);
        }
        element = [[WFXGeneralElement alloc] initWithValidator:_rootValidator];
        _root = element;
    } else{
        id tmp = [_currentValidator validatorForElement:elementName];
        if (!tmp) {
            @throw wfx_exception(_parser, @"Validation failed. Encounter unexpected element '%@'.", elementName);
        }
        _currentValidator = tmp;
        element = [[WFXGeneralElement alloc] initWithValidator:_currentValidator];
        [_tail addChild:element];
    }
    _tail = element;
    _mixedContent = [NSMutableString string];
}
-(WFXGeneralElement *)endElement:(NSString *)elementName{
    NSAssert([elementName isEqualToString:_tail.name], nil);
    
    id r = _tail;
    _tail = _tail.parent;
    _currentValidator = _tail.validator;
    return r;
}
-(void)processAttributes:(NSDictionary<NSString *, NSString *> *)attributes{
    for (NSString *k in attributes.allKeys) {
        [_currentValidator document:self element:_tail validateAttribute:k value:attributes[k]];
    }
}
-(void)processCDATA:(NSData *)CDATABlock{
    [_currentValidator document:self element:_tail validateCDATA:CDATABlock];
}
@end
