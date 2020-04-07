//
//  DaoAdditionalTests.m
//  WFDataSourceTests
//
//  Created by Jerry on 2020/1/5.
//  Copyright © 2020 Wind Fant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <WFDataSource/WFDataSource.h>
#import "DaoAdditionalDao.h"
#import "WFDSConnection+Internal.h"
#import "WFDSDaoManager+Internal.h"
#import "WFDSStreamProcessor.h"

@interface DaoAdditionalTests : XCTestCase
@property (nonatomic, strong) WFDSConnection *connection;
@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) id<DaoAdditionalDao> dao;
@end

/**
 This test mainly try to cover the dao module as much as possible. It is a supplement of the basic tests.
 */
@implementation DaoAdditionalTests
-(void)setUp {
    self.connection = [WFDSConnection connectionForMemorySource];
    self.bundle = [NSBundle bundleForClass:[self class]];
    [WFDSStreamProcessor.sharedProcessor connection:self.connection processBatchInBundle:self.bundle];
    NSURL *url = [self.bundle URLForResource:@"dao_additional" withExtension:@"dao.xml"];
    self.dao = [WFDSDaoManager.sharedManager instantiateDaoWithConnection:self.connection scriptURL:url protocol:@protocol(DaoAdditionalDao)];
}
-(void)tearDown {
    [self.connection close];
}
-(void)test01 {
    // cover selector '-processSQLStreamInMainBundle'
    XCTAssertNoThrow([self.connection processSQLStreamInMainBundle], @"Error occur during invoke '-processSQLStreamInMainBundle'");
}
-(void)test02 {
    // The number of sql parameters and arguments of selector is not match. Should throw an exception.
    // The sql has 6 parameters but the selector has only 2 arguments.
    XCTAssertThrows([self.dao insertRecordWithNumber:0 decimal:0.0], @"Should throw an exception.");
}
-(void)test03 {
    // Use a incompatible type (float) as arguement in the dao selector. Should throw an exception.
    XCTAssertThrows([self.dao selectDecimal:3.14], @"Should throw an exception.");
}
-(void)test04 {
    // The entity has an property of type 'float' (Incompatible), which used as a parameter. Should throw an exception.
    ValueObjectA *record = [[ValueObjectA alloc] init];
    record.decimal = 3.14;
    XCTAssertThrows([self.dao insertRecord1:record], @"Should throw an exception.");
}
-(void)test05 {
    // The entity has an property of type 'NSData' (Incompatible), which used as a parameter. Should throw an exception.
    ValueObjectA *record = [[ValueObjectA alloc] init];
    record.text = [@"Hello World" dataUsingEncoding:NSUTF8StringEncoding];
    XCTAssertThrows([self.dao insertRecord2:record], @"Should throw an exception.");
}
-(void)test06 {
    // cover selector '-instantiateDaoWithConnection:script:protocol:'. Since the script not exist, should throw an exception.
    XCTAssertThrows([WFDSDaoManager.sharedManager instantiateDaoWithConnection:self.connection script:@"not_exist_script" protocol:@protocol(DaoAdditionalDao)]);
}
-(void)test07 {
    // The shortcut update statement excluded all columns. Should throw an exception.
    BasicValueObject *record = [[BasicValueObject alloc] init];
    XCTAssertThrows([self.dao updateRecord:record], @"Should throw an exception.");
}
-(void)test08 {
    // The shortcut insert statement excluded all columns. Should throw an exception.
    BasicValueObject *record = [[BasicValueObject alloc] init];
    XCTAssertThrows([self.dao insertRecord3:record], @"Should throw an exception.");
}
//-(void)test09 {
//    // The method request to return a entity of type 'EntityNotExist', which has no declaration. Should throw an exception.
//    NSURL *url = [self.bundle URLForResource:@"dao_additional2" withExtension:@"dao.xml"];
//    XCTAssertThrows([WFDSDaoManager.sharedManager instantiateDaoWithConnection:self.connection scriptURL:url protocol:@protocol(DaoAdditionalDao)],@"Should throw an exception.");
//}
-(void)test10 {
    // The operation returns a float, which is incompatible. Should throw an exception.
    XCTAssertThrows([self.dao selectDecimal], @"Should throw an exception.");
}
-(void)test11 {
    // The operation try to return compatible type (NSString), but the query returns nothing. Should throw an exception.
    XCTAssertThrows([self.dao selectNoRow], @"Should throw an exception.");
}
-(void)test12 {
    // The operation try to return compatible type (NSString), but the query returns more than 1 column. Should throw an exception.
    XCTAssertThrows([self.dao selectTooManyColumns], @"Should throw an exception.");
}
-(void)test13 {
    // The operation try to return an entity, but the query returns nothing. Should return a nil.
    XCTAssertNil([self.dao selectEntityButNoRow], @"Should return nil.");
}
-(void)test14 {
    // The query returns a record with two columns named 'number', which the 1st is 123, the 2nd is 321. The result should take the 1st one and ignore the 2nd.
    BasicValueObject *record = [self.dao selectColumnsWithRepeatedLabel];
    XCTAssertEqual(record.number, 123);
}
-(void)test15 {
    // The query returns a record contains column has no referred property. Operation should work without any problem.
    XCTAssertNoThrow([self.dao selectNotExistProperty], @"Should not throw.");
}
-(void)test16 {
    // The query returns a record contains column refer to readonly property. Operation should work without any problem.
    XCTAssertNoThrow([self.dao selectReadonlyProperty], @"Should not throw.");
}
-(void)test17 {
    // The query returns a record contains column refer to a property of incompatible type (NSNumber). Should throw an exception.
    XCTAssertThrows([self.dao selectIncompatibleProperty], @"Should throw an exception.");
}
-(void)test18 {
    // The query returns a record contains column refer to a property of incompatible type (float). Should throw an exception.
    XCTAssertThrows([self.dao selectIncompatibleProperty2], @"Should throw an exception.");
}
-(void)test19 {
    // The operation has no definition. Should throw an exception.
    XCTAssertThrows([self.dao selectNoDefinition], @"Should throw an exception.");
}
@end
