//
//  WFDSDaoManager.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import <WFDataSource/WFDSConnection.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFDSDaoManager : NSObject
+(instancetype)sharedManager;

-(id)instantiateDaoWithConnection:(WFDSConnection *)connection script:(NSString *)scriptName protocol:(Protocol *)protocol;
@end

NS_ASSUME_NONNULL_END
