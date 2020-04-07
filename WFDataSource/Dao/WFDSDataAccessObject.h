//
//  WFDSDataAccessObject.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//

#import <Foundation/Foundation.h>
#import "WFDSConnection.h"

NS_ASSUME_NONNULL_BEGIN

@class WFDSOperation;

@interface WFDSDataAccessObject : NSObject
@property (nonatomic, readonly, weak) Protocol *protocol;
@property (nonatomic, readonly, weak) WFDSConnection *connection;

-(instancetype)initWithConnection:(WFDSConnection *)connection protocol:(Protocol *)protocol;
-(void)addOperation:(WFDSOperation *)operation;
@end

NS_ASSUME_NONNULL_END
