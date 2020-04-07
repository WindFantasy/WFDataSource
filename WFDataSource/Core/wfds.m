//
//  wfds.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/5.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "wfds.h"
#import "WFDSConnection+Internal.h"

void wfds_info(NSString * format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSLog(@"[WF][DS] - %@", message);
}
NSException *wfds_exception(NSString *format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSString *reason = [NSString stringWithFormat:@"[WF][DS][ERROR] - %@", message];
    return [NSException exceptionWithName:@"NSException" reason:reason userInfo:nil];
}
NSException *wfds_exceptionA(WFDSStatement *statement, NSString *format, ...){
    sqlite3 *sqlite = statement.connection.sqlite;
    NSString *sql = statement.sql;
    
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    int code = sqlite3_errcode(statement.connection.sqlite);
    NSString *reason;
    if (code == SQLITE_OK) {
        reason = [NSString stringWithFormat:@"[WF][DS][ERROR] - %@ SQL: \n%@", message, sql];
    } else {
        reason = [NSString stringWithFormat:@"[WF][DS][ERROR] - %@ (%s). SQL: \n%@", message, sqlite3_errmsg(sqlite), sql];
    }
    return [NSException exceptionWithName:@"NSException" reason:reason userInfo:nil];
}
NSInteger wfds_getUserVersion(WFDSConnection *connection){
    WFDSStatement *statement = [connection prepareStatement:@"PRAGMA user_version"];
    WFDSResultSet *resultSet = [statement executeQuery];
    BOOL r = [resultSet next];
    assert(r); // No rows return
    NSInteger n = [resultSet integerForColumnAtIndex:0];
    [resultSet close];
    [statement close];
    return n;
}
void wfds_setUserVersion(WFDSConnection *connection, NSInteger value){
    // PRAGMA statement cannot bind parameter and no update count
    NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version = %d", (int)value];
    WFDSStatement *statement = [connection prepareStatement:sql];
    [statement executeUpdate];
    [statement close];
}
