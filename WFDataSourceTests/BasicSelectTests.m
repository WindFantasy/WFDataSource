//
//  WFDataSourceTests.m
//  WFDataSourceTests
//
//  Created by Jerry on 2019/12/5.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <WFDataSource/WFDataSource.h>
#import "BasicSelectDao.h"
#import "BasicValueObject.h"
#import "WFDSConnection+Internal.h"
#import "WFDSDaoManager+Internal.h"
#import <objc/runtime.h>

@interface WFDataSourceTests : XCTestCase
@property (nonatomic, strong) WFDSConnection *connection;
@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) id<BasicSelectDao> dao;
@end

@implementation WFDataSourceTests

-(void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.connection = [WFDSConnection connectionForMemorySource];
    self.bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [self.bundle URLForResource:@"basic_select" withExtension:@"dao.xml"];
    self.dao = [WFDSDaoManager.sharedManager instantiateDaoWithConnection:self.connection scriptURL:url protocol:@protocol(BasicSelectDao)];
}

-(void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [self.connection close];
}

-(void)test01 {
    NSString *m = [self.dao selectHelloWorld];
    XCTAssertEqualObjects(m, @"Hello World");
}
-(void)test02 {
    NSInteger n = [self.dao selectNumber];
    XCTAssertEqual(n, 1024);
}
-(void)test03 {
    double n = [self.dao selectDecimal];
    XCTAssertEqual(n, 3.14);
}
-(void)test04 {
    NSDate *d = [NSDate dateWithTimeIntervalSinceReferenceDate:1000.1234];
    NSDate *d2 = [self.dao selectDate];
    XCTAssertEqualObjects(d, d2);
}
-(void)test05 {
    BOOL n = [self.dao selectTrue];
    XCTAssertTrue(n);
}
-(void)test06 {
    BasicValueObject *o = [self.dao selectRecord];
    XCTAssertTrue(o.booleanValue);
    XCTAssertEqual(o.number, 1024);
    XCTAssertEqual(o.decimal, 3.14);
    XCTAssertEqualObjects(o.text, @"Hello World");
    XCTAssertEqualObjects(o.date, [NSDate dateWithTimeIntervalSinceReferenceDate:1000.1234]);
}

-(void)test07 {
    BOOL value = [self.dao selectBoolean:YES];
    XCTAssertTrue(value);
    value = [self.dao selectBoolean:NO];
    XCTAssertFalse(value);
}
-(void)test08 {
    srand((int)time(0));
    
    for (int i = 0; i < 10; i++) {
        int n = rand();
        NSInteger value = [self.dao selectNumber:n];
        XCTAssertEqual(n, value);
    }
}
-(void)test09 {
    srand((int)time(0));
    
    for (int i = 0; i < 10; i++) {
        double n = rand() / 100000;
        NSInteger value = [self.dao selectDecimal:n];
        XCTAssertEqual(n, value);
    }
}
-(void)test10 {
    NSString *src = @"Some me the money!";
    NSString *dest = [self.dao selectText:src];
    XCTAssertEqualObjects(src, dest);
    
    dest = [self.dao selectText:nil];
    XCTAssertNil(dest);
}
-(void)test10_1 {
    NSString *dest = [self.dao selectText:nil];
    XCTAssertNil(dest);
}
-(void)test11 {
    NSDate *src = [NSDate date];
    NSDate *dest = [self.dao selectDate:src];
    XCTAssertEqualObjects(src, dest);
    
    dest = [self.dao selectDate:nil];
    XCTAssertNil(dest);
}
-(void)test11_1 {
    NSDate *dest = [self.dao selectDate:nil];
    XCTAssertNil(dest);
}
-(void)test12 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = @"fire in the hole!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    BasicValueObject *dest = [self.dao selectRecord:src];
    
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertEqualObjects(src.text, dest.text);
    XCTAssertEqualObjects(src.date, dest.date);
}
-(void)test12_1 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = nil;
    src.date = nil;
    
    BasicValueObject *dest = [self.dao selectRecord:src];
    
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertNil(dest.text);
    XCTAssertNil(dest.date);
}
-(void)test13 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = @"fire in the hole!";
    src.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    BasicValueObject *dest = [self.dao selectRecordWithBoolean:src.booleanValue number:src.number decimal:src.decimal text:src.text date:src.date];
    
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertEqualObjects(src.text, dest.text);
    XCTAssertEqualObjects(src.date, dest.date);
}
-(void)test13_1 {
    BasicValueObject *src = [[BasicValueObject alloc] init];
    src.booleanValue = YES;
    src.number = 8848;
    src.decimal = 1.60218;
    src.text = nil;
    src.date = nil;
    
    BasicValueObject *dest = [self.dao selectRecordWithBoolean:src.booleanValue number:src.number decimal:src.decimal text:src.text date:src.date];
    
    XCTAssertEqual(src.booleanValue, dest.booleanValue);
    XCTAssertEqual(src.number, dest.number);
    XCTAssertEqual(src.decimal, dest.decimal);
    XCTAssertNil(dest.text);
    XCTAssertNil(dest.date);
}
-(void)test14 {
    BasicValueObject *o = [self.dao selectRecords][0];
    XCTAssertTrue(o.booleanValue);
    XCTAssertEqual(o.number, 1024);
    XCTAssertEqual(o.decimal, 3.14);
    XCTAssertEqualObjects(o.text, @"Hello World");
    XCTAssertEqualObjects(o.date, [NSDate dateWithTimeIntervalSinceReferenceDate:1000.1234]);
}
@end
