//
//  WFDSResultSet.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/9.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFDSResultSet.h"
#import "WFDSStatement.h"
#import "wfds.h"

@interface WFDSResultSet()
@property (nonatomic, assign, readonly) sqlite3_stmt *stmt;
@end

@implementation WFDSResultSet{
    BOOL _ready;
    BOOL _done;
    BOOL _isClosed;
}
+(instancetype)resultSetWithStatement:(WFDSStatement *)statement{
    return [[WFDSResultSet alloc] initWithStatement:statement];
}
-(instancetype)initWithStatement:(WFDSStatement *)statement{
    self = [super init];
    if (self) {
        _statement = statement;
        _stmt = statement.stmt;
        _numColumn = sqlite3_column_count(statement.stmt);
    }
    return self;
}
-(void)dealloc{
    NSAssert(_statement == NULL, @"Result set not yet closed.");
}
-(void)close{
    _isClosed = YES;
}
-(BOOL)next{
    NSAssert(!_isClosed, @"Result set is closed.");
    NSAssert(!_done, @"Already reach the end of this result set.");
    int r = sqlite3_step(_stmt);
    if (r == SQLITE_ROW) {
        _ready = YES;
        return YES;
    }
    NSAssert(r == SQLITE_DONE, @"Move cursor failed.");
    _done = YES;
    return NO;
}
-(NSInteger)integerForColumnAtIndex:(NSUInteger)index{
    NSAssert(!_isClosed, @"Result set is closed.");
    NSAssert(_ready, @"Result set is not yet ready.");
    NSAssert(!_done, @"Already reach the end of this result set.");
    NSAssert(index >= 0 && index < _numColumn, @"Found invalid column index.");
    int type = sqlite3_column_type(_stmt, (int)index);
    if (type == SQLITE_NULL) {
        return 0;
    }
    if (type != SQLITE_INTEGER) {
        @throw wfds_exceptionA(self.statement, @"Access data failed (column index %d). Not an integer.", index);
    }
    return sqlite3_column_int64(_stmt, (int)index);
}
-(double)doubleForColumnAtIndex:(NSUInteger)index{
    NSAssert(!_isClosed, @"Result set is closed.");
    NSAssert(_ready, @"Result set is not yet ready.");
    NSAssert(!_done, @"Already reach the end of this result set.");
    NSAssert(index >= 0 && index < _numColumn, @"Found invalid column index.");
    int type = sqlite3_column_type(_stmt, (int)index);
    if (type == SQLITE_NULL) {
        return 0;
    }
    if (type != SQLITE_FLOAT) {
        @throw wfds_exceptionA(self.statement, @"Access data failed (column index %d). Not a float.", index);
    }
    return sqlite3_column_double(_stmt, (int)index);
}
@end
