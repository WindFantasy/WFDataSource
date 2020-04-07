//
//  WFDSStatement.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/9.
//

#import "WFDSStatement.h"
#import "wfds.h"
#import "WFDSConnection.h"

@interface WFDSConnection()
@property (nonatomic, readonly, assign) sqlite3 *sqlite;
@end

@interface WFDSStatement()
@end

@implementation WFDSStatement{
    WFDSResultSet *_resultSet;
}
+ (instancetype)statementWithConnection:(WFDSConnection *)connection SQL:(NSString *)sql{
    return [[WFDSStatement alloc] initWithConnection:connection SQL:sql];
}
-(instancetype)initWithConnection:(WFDSConnection *)connection SQL:(NSString *)sql{
    self = [super init];
    if (self) {
        _connection = connection;
        _sql = sql;
        NSData *d = [sql dataUsingEncoding:NSUTF8StringEncoding];
        sqlite3_stmt *stmt;
        sqlite3 *sqlite = connection.sqlite;
        const char *buf = d.bytes;
        int len = (int)d.length;
        int r = sqlite3_prepare_v2(sqlite, buf, len, &stmt, NULL);
        if (r != SQLITE_OK) {
            @throw wfds_exceptionA(self, @"Prepare statement failed.");
        }
        _stmt = stmt;
    }
    return self;
}
-(void)dealloc{
    NSAssert(_stmt == NULL, @"Statement not yet closed.");
}
-(void)close{
    NSAssert(_stmt != NULL, @"Statement already closed.");
    [_resultSet close];
    int r = sqlite3_finalize(_stmt);
    NSAssert(r == SQLITE_OK, @"Close statement failed.");
    _stmt = NULL;
}
/// @returns YES if the execution is about a query statement.
-(BOOL)execute{
    int count = sqlite3_column_count(_stmt);
    if (count == 0) {   // non-query statement
        int r = sqlite3_step(_stmt);
        if (r != SQLITE_DONE) {
            @throw wfds_exceptionA(self, @"Execution failed.");
        }
        return NO;
    }
    return YES;
}
-(NSUInteger)executeUpdate{
    BOOL r = [self execute];
    NSAssert(!r, @"You may called -executeUpdate with a query statement.");
    return sqlite3_changes(_connection.sqlite);
}
-(WFDSResultSet *)executeQuery{
    BOOL r = [self execute];
    NSAssert(r, @"You may called -executeQuery with a non-query statement.");
    return _resultSet = [WFDSResultSet resultSetWithStatement:self];
}
@end
