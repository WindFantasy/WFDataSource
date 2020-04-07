//
//  WFXmlParser+Internal.h
//  WFDataSource
//
//  Created by Jerry on 2020/1/4.
//  Copyright © 2020 Wind Fant. All rights reserved.
//
#import "WFXmlParser.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFXmlParser ()
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, strong, readonly) NSXMLParser *parser;
@end

NS_ASSUME_NONNULL_END
