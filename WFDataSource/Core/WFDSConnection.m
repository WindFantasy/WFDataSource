//
//  WFDSConnection.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/5.
//

#import "WFDSConnection+Internal.h"
#import <sqlite3.h>
#import "wfds.h"
#import "WFDSStatement.h"
#import "WFDSStreamProcessor.h"

@interface WFDSConnection()
@end

@implementation WFDSConnection
+(void)load{
    if(sizeof(NSInteger) != 8) {
        @throw wfds_exception(@"WFDataSource is not compatible to 32 bit devices.");
    }
}
+(instancetype)connectionWithDocumentPath:(NSString *)path{
    NSString *thePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    thePath = [thePath stringByAppendingPathComponent:path];
    wfds_info(@"Opening source: %@ ...", thePath);
    return [[WFDSConnection alloc] initWithPath:thePath];
}
+(instancetype)connectionForMemorySource{
    wfds_info(@"Opening in-memory source ...");
    return [[WFDSConnection alloc] initWithPath:@":memory:"];
}
-(instancetype)initWithPath:(NSString *)path{
    self = [super init];
    if (self) {
        const char *file = path.UTF8String;
        int r = sqlite3_open_v2(file, &_sqlite, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL);
        NSAssert(r == SQLITE_OK, @"Open source failed.");
    }
    return self;
}
-(void)dealloc{
    if (_sqlite != NULL) {
        @throw wfds_exception(@"Source was not closed yet.");
    }
}
-(void)close{
    if (_sqlite == NULL) {
        return;
    }
    int r = sqlite3_close(_sqlite);
    NSAssert(r == SQLITE_OK, @"Close source failed.");
    _sqlite = NULL;
    wfds_info(@"Source closed.");
}
-(void)execute:(NSString *)sql{
    WFDSStatement *statement = [self prepareStatement:sql];
    [statement executeUpdate];
    [statement close];
}
-(void)begin{
    [self execute:@"BEGIN"];
}
-(void)commit{
    [self execute:@"COMMIT"];
}
-(void)rollback{
    [self execute:@"ROLLBACK"];
}
-(WFDSStatement *)prepareStatement:(NSString *)sql{
    NSAssert(_sqlite != NULL, @"Connection already closed.");
    return [WFDSStatement statementWithConnection:self SQL:sql];
}
-(void)processSQLStreamInMainBundle{
    [WFDSStreamProcessor.sharedProcessor connection:self processBatchInBundle:nil];
}
- (void)performTransaction:(void (^)(void))execution{
    @try {
        [self begin];
        execution();
        [self commit];
    } @catch (NSException *exception) {
        [self rollback];
        @throw exception;
    }
}
@end
