//
//  WFDSDaoManager+Internal.h
//  WFDataSource
//
//  Created by Jerry on 2020/1/3.
//
#import "WFDSDaoManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFDSDaoManager ()
-(id)instantiateDaoWithConnection:(WFDSConnection *)connection scriptURL:(NSURL *)url protocol:(Protocol *)protocol;
@end

NS_ASSUME_NONNULL_END
