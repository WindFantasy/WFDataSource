//
//  WFDSStreamProcessor.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFDataSource/WFDSConnection.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFDSStreamProcessor : NSObject
+(instancetype)sharedProcessor;
-(void)connection:(WFDSConnection *)connection processBatchInBundle:(nullable NSBundle *)bundle;
@end

NS_ASSUME_NONNULL_END
