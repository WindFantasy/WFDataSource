//
//  wfds.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/5.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "WFDSStatement.h"

NS_ASSUME_NONNULL_BEGIN

void wfds_info(NSString * format, ...);

NSException *wfds_exception(NSString *format, ...);
NSException *wfds_exceptionA(WFDSStatement *statement, NSString *format, ...);

NSInteger wfds_getUserVersion(WFDSConnection *connection);
void wfds_setUserVersion(WFDSConnection *connection, NSInteger value);

NS_ASSUME_NONNULL_END
