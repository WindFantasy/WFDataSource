//
//  WFDSConnection.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/5.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFDSConnection : NSObject
+(instancetype)connectionWithDocumentPath:(NSString *)path;

-(void)close;

-(void)begin;
-(void)commit;
-(void)rollback;
@end

@interface WFDSConnection(Stream)
-(void)processSQLStreamInMainBundle;
@end

NS_ASSUME_NONNULL_END
