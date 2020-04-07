//
//  WFDSStatement.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/9.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "WFDSResultSet.h"

NS_ASSUME_NONNULL_BEGIN
@class WFDSConnection;

@interface WFDSStatement : NSObject
@property (nonatomic, weak, readonly) WFDSConnection *connection;
@property (nonatomic, strong, readonly) NSString *sql;
@property (nonatomic, readonly, nullable) sqlite3_stmt *stmt;

+(instancetype)statementWithConnection:(WFDSConnection *)connection SQL:(NSString *)sql;
-(void)close;

-(NSUInteger)executeUpdate;
-(WFDSResultSet *)executeQuery;
@end

NS_ASSUME_NONNULL_END
