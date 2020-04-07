//
//  wfxsd.m
//  WFDataSource
//
//  Created by Jerry on 2020/1/4.
//  Copyright © 2020 Wind Fant. All rights reserved.
//

#import "wfxsd.h"
#import "WFXmlParser+Internal.h"

void wfx_info(WFXmlParser *parser, NSString * format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSLog(@"[WF][XSD][%@] - %@\n", parser.url.lastPathComponent, message);
}
NSException *wfx_exception(WFXmlParser *parser, NSString *format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSString *reason = [NSString stringWithFormat:@"[WF][XSD][ERROR][L:%d] - (%@) %@", (int)parser.parser.lineNumber, parser.parser.parserError.localizedDescription, message];
    return [NSException exceptionWithName:@"NSException" reason:reason userInfo:nil];
}
