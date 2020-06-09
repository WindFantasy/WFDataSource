//
//  WFXDocument.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/7.
//

#import <Foundation/Foundation.h>
#import "WFXElementValidator.h"
#import "WFXGeneralElement.h"
#import "WFXmlParser+Internal.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFXDocument : NSObject
@property (nonatomic, readonly, weak) WFXmlParser *parser;
@property (nonatomic, readonly) WFXGeneralElement *root;
@property (nonatomic, readonly) WFXGeneralElement *tail;

-(instancetype)initWithValidator:(WFXElementValidator *)rootValidator parser:(WFXmlParser *)parser;
-(void)startElement:(NSString *)elementName;
-(WFXGeneralElement *)endElement:(NSString *)elementName;

-(void)processAttributes:(NSDictionary<NSString *, NSString *> *)attributes;
-(void)processCDATA:(NSData *)CDATABlock;
@end

NS_ASSUME_NONNULL_END
