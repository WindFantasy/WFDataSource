//
//  WFXDocument.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/7.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFXElementValidator.h"
#import "WFXGeneralElement.h"
#import "WFXmlParser+Internal.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFXDocument : NSObject
@property (nonatomic, weak, readonly) WFXmlParser *parser;
@property (nonatomic, readonly) WFXGeneralElement *root;
@property (nonatomic, readonly) WFXGeneralElement *tail;

-(instancetype)initWithValidator:(WFXElementValidator *)rootValidator parser:(WFXmlParser *)parser;
-(void)startElement:(NSString *)elementName;
-(WFXGeneralElement *)endElement:(NSString *)elementName;

-(void)processAttributes:(NSDictionary<NSString *, NSString *> *)attributes;
-(void)processCDATA:(NSData *)CDATABlock;
@end

NS_ASSUME_NONNULL_END
