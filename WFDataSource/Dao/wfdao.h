//
//  wfdao.h
//  WFDataSource
//
//  Created by Jerry on 2020/1/4.
//

#import <Foundation/Foundation.h>
#import "WFDSOperation.h"
#import "WFDSDataAccessObject.h"

NS_ASSUME_NONNULL_BEGIN

void wfdao_info(NSString * format, ...);
void wfdao_infoA(WFDSOperation * operation, NSString * format, ...);
void wfdao_infoB(WFDSDataAccessObject *dao, NSString * format, ...);
NSException *wfdao_exception(WFDSOperation * _Nullable operation, NSString *format, ...);

NSString *wfds_toCamel(const char *underScore);

NS_ASSUME_NONNULL_END
