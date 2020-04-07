//
//  BasicUpdateTests.m
//  WFDataSourceTests
//
//  Created by Jerry on 2020/1/3.
//

#import <XCTest/XCTest.h>
#import <WFDataSource/WFDataSource.h>
#import "BasicUpdateDao.h"
#import "WFDSConnection+Internal.h"
#import "WFDSDaoManager+Internal.h"
#import "WFDSStreamProcessor.h"

@interface BasicUpdateTests : XCTestCase
@property (nonatomic, strong) WFDSConnection *connection;
@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) id<BasicUpdateDao> dao;
@end

@implementation BasicUpdateTests

-(void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.connection = [WFDSConnection connectionForMemorySource];
    self.bundle = [NSBundle bundleForClass:[self class]];
    [WFDSStreamProcessor.sharedProcessor connection:self.connection processBatchInBundle:self.bundle];
    NSURL *url = [self.bundle URLForResource:@"basic_update" withExtension:@"dao.xml"];
    self.dao = [WFDSDaoManager.sharedManager instantiateDaoWithConnection:self.connection scriptURL:url protocol:@protocol(BasicUpdateDao)];
}

-(void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [self.connection close];
}

-(void)test01 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.identity = @"id001";
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = @"fire in the hole!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    NSUInteger n = [self.dao insertRecord:src];
    
    XCTAssertEqual(n, 1);
    
    BasicValueObject *dest = [self.dao selectRecord];
    
    XCTAssertEqualObjects(src.identity, dest.identity);
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertEqualObjects(src.text, dest.text);
    XCTAssertEqualObjects(src.date, dest.date);
    
    src.booleanValue = NO;
    src.number = 1024;
    src.decimal = 3.14;
    src.text = @"hello world!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000.234];
    n = [self.dao updateRecord:src];
    
    dest = [self.dao selectRecord];
    
    XCTAssertEqualObjects(src.identity, dest.identity);
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertEqualObjects(src.text, dest.text);
    XCTAssertEqualObjects(src.date, dest.date);
    
    
    src.booleanValue = YES;
    src.number = 0;
    src.decimal = 0.0;
    src.text = nil;
    src.date = nil;
    n = [self.dao updateRecord:src];
    
    dest = [self.dao selectRecord];
    
    XCTAssertEqualObjects(src.identity, dest.identity);
    XCTAssertEqual(dest.booleanValue, YES);
    XCTAssertEqual(dest.number, 0);
    XCTAssertEqual(dest.decimal, 0);
    XCTAssertNil(dest.text);
    XCTAssertNil(dest.date);
}
-(void)test01_1 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.identity = nil;
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = nil;
    src.date = nil;
    
    NSUInteger n = [self.dao insertRecord:src];
    
    XCTAssertEqual(n, 1);
    
    BasicValueObject *dest = [self.dao selectRecord];
    
    XCTAssertNil(dest.identity);
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertNil(dest.text);
    XCTAssertNil(dest.date);
}
-(void)test01_2 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.identity = @"id001";
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = @"fire in the hole!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    NSUInteger n = [self.dao insertRecord:src];
    
    XCTAssertEqual(n, 1);
    
    BasicValueObject *dest = [self.dao selectRecord];
    
    XCTAssertEqualObjects(src.identity, dest.identity);
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertEqualObjects(src.text, dest.text);
    XCTAssertEqualObjects(src.date, dest.date);
    
    src.booleanValue = NO;
    src.number = 1024;
    src.decimal = 3.14;
    src.text = @"hello world!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000.234];
    n = [self.dao updateRecordShortcut:src];
    
    dest = [self.dao selectRecord];
    
    XCTAssertEqualObjects(src.identity, dest.identity);
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertEqualObjects(src.text, dest.text);
    XCTAssertEqualObjects(src.date, dest.date);
    
    
    src.booleanValue = YES;
    src.number = 0;
    src.decimal = 0.0;
    src.text = nil;
    src.date = nil;
    n = [self.dao updateRecordShortcut:src];
    
    dest = [self.dao selectRecord];
    
    XCTAssertEqualObjects(src.identity, dest.identity);
    XCTAssertEqual(dest.booleanValue, YES);
    XCTAssertEqual(dest.number, 0);
    XCTAssertEqual(dest.decimal, 0);
    XCTAssertNil(dest.text);
    XCTAssertNil(dest.date);
}

-(void)test02 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.identity = @"id001";
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = @"fire in the hole!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    NSUInteger n = [self.dao insertRecordShortcut:src];
    
    XCTAssertEqual(n, 1);
    
    BasicValueObject *dest = [self.dao selectRecord];
    
    // insertRecordShortcut: excludes column 'identity'
    XCTAssertNil(dest.identity);
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertEqualObjects(src.text, dest.text);
    XCTAssertEqualObjects(src.date, dest.date);
}
-(void)test03 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.identity = @"id001";
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = @"fire in the hole!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    NSUInteger n = [self.dao insertRecordShortcut2:src];
    
    XCTAssertEqual(n, 1);
    
    BasicValueObject *dest = [self.dao selectRecord];
    
    // insertRecordShortcut2: excludes all columns except 'identity'
    XCTAssertEqualObjects(src.identity, dest.identity);
    XCTAssertEqual(dest.booleanValue, NO);
    XCTAssertEqual(dest.number, 0);
    XCTAssertEqual(dest.decimal, 0.0);
    XCTAssertNil(dest.text);
    XCTAssertNil(dest.date);
}
-(void)test04 {
    BasicValueObject *record1 = [[BasicValueObject alloc] init];
    record1.identity = @"id001";
    record1.booleanValue = YES;
    record1.number = 8848;
    record1.decimal = 1.60218;
    record1.text = @"fire in the hole!";
    record1.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    NSUInteger n = [self.dao insertRecord:record1];
    
    XCTAssertEqual(n, 1);
    
    BasicValueObject *record2 = [[BasicValueObject alloc] init];
    record2.identity = @"id002";
    record2.booleanValue = NO;
    record2.number = 1024;
    record2.decimal = 3.14;
    record2.text = @"hello world!";
    record2.date = [NSDate dateWithTimeIntervalSinceNow:1000.234];
    n = [self.dao insertRecord:record2];
    
    XCTAssertEqual(n, 1);
    
    NSArray<BasicValueObject *> *records = [self.dao selectRecords];
    
    XCTAssertEqual(records.count, 2);
    XCTAssertEqualObjects(records[0].identity, @"id001");
    XCTAssertEqualObjects(records[1].identity, @"id002");
    
    n = [self.dao deleteRecord:@"id003"];
    XCTAssertEqual(n, 0);
    
    n = [self.dao deleteRecord:@"id001"];
    XCTAssertEqual(n, 1);
    
    records = [self.dao selectRecords];
    XCTAssertEqual(records.count, 1);
    XCTAssertEqualObjects(records[0].identity, @"id002");
    
    n = [self.dao deleteRecord:@"id002"];
    XCTAssertEqual(n, 1);
    
    records = [self.dao selectRecords];
    XCTAssertEqual(records.count, 0);
}
-(void)test05 {
    // test unicode encoding
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.identity = @"id001";
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = @"好好学习，天天向上!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    NSUInteger n = [self.dao insertRecord:src];
    
    XCTAssertEqual(n, 1);
    
    BasicValueObject *dest = [self.dao selectRecord];
    
    XCTAssertEqualObjects(src.identity, dest.identity);
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertEqualObjects(src.text, dest.text);
    XCTAssertEqualObjects(src.date, dest.date);
}
-(void)test06 {
    BasicValueObject *dest = [self.dao selectUnicodeRecord];
    XCTAssertEqualObjects(dest.text, @"好好学习，天天向上!");
}
@end
