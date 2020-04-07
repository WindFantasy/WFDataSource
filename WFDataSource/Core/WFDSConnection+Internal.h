//
//  WFDSConnection+Internal.h
//  WFDataSource
//
//  Created by Jerry on 2020/1/2.
//

#import "WFDSConnection.h"
#import "WFDSStatement.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFDSConnection()
@property (nonatomic, readonly, nullable) sqlite3 *sqlite;

+(instancetype)connectionForMemorySource;

-(void)execute:(NSString *)sql;
-(WFDSStatement *)prepareStatement:(NSString *)sql;
@end

NS_ASSUME_NONNULL_END
