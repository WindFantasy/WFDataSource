//
//  wfxsd.h
//  WFDataSource
//
//  Created by Jerry on 2020/1/4.
//

#import <Foundation/Foundation.h>
#import "WFXmlParser.h"

NS_ASSUME_NONNULL_BEGIN

void wfx_info(WFXmlParser *parser, NSString * format, ...);
NSException *wfx_exception(WFXmlParser *_Nullable parser, NSString *format, ...);

NS_ASSUME_NONNULL_END
