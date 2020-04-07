//
//  WFXGeneralValidator.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFXElementValidator.h"
#import "wfxsd.h"
#import "WFXDocument.h"

@interface WFXElementValidator()
@end

@implementation WFXElementValidator{
    NSSet<NSString *> *choiceNames;
}
-(WFXElementValidator *)validatorForElement:(NSString *)elementName{
    if (self.choices) {
        return self.choices[elementName].validator;
    }
    return nil;
}
-(void)document:(WFXDocument *)document element:(WFXGeneralElement *)element validateAttribute:(NSString *)attributeName value:(NSString *)value{
    WFXAttributeValidator *attribute = self.attributes[attributeName];
    if (!attribute) {
        @throw wfx_exception(document.parser, @"Found unexpected attribute '%@'.", attributeName);
    }
    switch (attribute.type) {
        case WFStringAttribute:
            [element attribute:attributeName setString:value];
            break;
        case WFBooleanAttribute:
            if ([value isEqualToString:@"true"]) {
                [element attribute:attributeName setBoolean:YES];
            } else if ([value isEqualToString:@"false"]) {
                [element attribute:attributeName setBoolean:NO];
            } else {
                @throw wfx_exception(document.parser, @"Invalid value. Value of '%@' neither 'true' nor 'false'.", attributeName);
            }
            break;
        default:
            NSAssert(NO, @"Unexpected attribute type.");
            break;
    }
}
-(void)document:(WFXDocument *)document element:(WFXGeneralElement *)element validateCDATA:(NSData *)CDATABlock{
    if (!self.mixed) {
        @throw wfx_exception(document.parser, @"CDATA is not allowed by <%@>.", self.name);
    }
    element.value = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
}
@end
