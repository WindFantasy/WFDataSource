//
//  WFDSDataAccessObject.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFDSConnection.h"

NS_ASSUME_NONNULL_BEGIN

@class WFDSOperation;

@interface WFDSDataAccessObject : NSObject
@property (nonatomic, weak, readonly) Protocol *protocol;
@property (nonatomic, weak, readonly) WFDSConnection *connection;

-(instancetype)initWithConnection:(WFDSConnection *)connection protocol:(Protocol *)protocol;
-(void)addOperation:(WFDSOperation *)operation;
@end

NS_ASSUME_NONNULL_END
