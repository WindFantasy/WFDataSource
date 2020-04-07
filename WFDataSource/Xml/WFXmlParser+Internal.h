//
//  WFXmlParser+Internal.h
//  WFDataSource
//
//  Created by Jerry on 2020/1/4.
//

#import "WFXmlParser.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFXmlParser ()
@property (nonatomic, readonly, copy) NSURL *url;
@property (nonatomic, readonly, strong) NSXMLParser *parser;
@end

NS_ASSUME_NONNULL_END
