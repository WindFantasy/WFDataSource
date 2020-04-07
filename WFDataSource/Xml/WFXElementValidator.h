//
//  WFXGeneralValidator.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "WFXValidator.h"
#import "WFXOccurrence.h"
#import "WFXGeneralElement.h"
#import "WFXAttributeValidator.h"

NS_ASSUME_NONNULL_BEGIN
@class WFXDocument;

@interface WFXElementValidator : NSObject<WFXValidator>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL mixed;
@property (nonatomic, copy) NSDictionary<NSString *, WFXOccurrence *> *choices;
@property (nonatomic, copy) NSDictionary<NSString *, WFXAttributeValidator *> *attributes;

-(nullable WFXElementValidator *)validatorForElement:(NSString *)elementName;
-(void)document:(WFXDocument *)document element:(WFXGeneralElement *)element validateAttribute:(NSString *)attribute value:(NSString *)value;
-(void)document:(WFXDocument *)document element:(WFXGeneralElement *)element validateCDATA:(NSData *)CDATABlock;
@end

NS_ASSUME_NONNULL_END
