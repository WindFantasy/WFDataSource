//
//  WFDSConnection+Internal.h
//  WFDataSource
//
//  Created by Jerry on 2020/1/2.
//  Copyright © 2020 Wind Fant. All rights reserved.
//
#import "WFDSConnection.h"
#import "WFDSStatement.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFDSConnection()
@property (nonatomic, nullable, readonly) sqlite3 *sqlite;

+(instancetype)connectionForMemorySource;

-(void)execute:(NSString *)sql;
-(WFDSStatement *)prepareStatement:(NSString *)sql;
@end

NS_ASSUME_NONNULL_END
