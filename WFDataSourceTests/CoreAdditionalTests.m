//
//  CoreAdditionalTests.m
//  WFDataSourceTests
//
//  Created by Jerry on 2020/1/5.
//

#import <XCTest/XCTest.h>
#import <WFDataSource/WFDataSource.h>
#import "WFDSConnection+Internal.h"
#import "WFDSStreamProcessor.h"

@interface CoreAdditionalTests : XCTestCase
@property (nonatomic, strong) WFDSConnection *connection;
@property (nonatomic, strong) NSBundle *bundle;
@end

@implementation CoreAdditionalTests

- (void)setUp {
    self.connection = [WFDSConnection connectionForMemorySource];
    self.bundle = [NSBundle bundleForClass:[self class]];
    [WFDSStreamProcessor.sharedProcessor connection:self.connection processBatchInBundle:self.bundle];
}

- (void)tearDown {
    [self.connection close];
}

-(void)test01 {
    // To prepare a statement with syntax error. Should throw an exception.
    XCTAssertThrows([self.connection prepareStatement:@"Invalid SQL"], @"Should throw an exception.");
}
-(void)test02 {
    // Execute a statement after close. . Should throw an exception.
    WFDSStatement *statement = [self.connection prepareStatement:@"SELECT 123"];
    [statement close];
    XCTAssertThrows([statement executeQuery], @"Should throw an exception.");
}
-(void)test03 {
    // -[WFDSResultSet integerForColumnAtIndex:] return 0 if the value is NULL.
    WFDSStatement *statement = [self.connection prepareStatement:@"SELECT NULL"];
    WFDSResultSet *resultSet = [statement executeQuery];
    
    [resultSet next];
    NSInteger n = [resultSet integerForColumnAtIndex:0];
    XCTAssertEqual(n, 0);
    [resultSet close];
    [statement close];
}
-(void)test04 {
    // -[WFDSResultSet doubleForColumnAtIndex:] return 0 if the value is NULL.
    WFDSStatement *statement = [self.connection prepareStatement:@"SELECT NULL"];
    WFDSResultSet *resultSet = [statement executeQuery];
    
    [resultSet next];
    double n = [resultSet doubleForColumnAtIndex:0];
    XCTAssertEqual(n, 0);
    [resultSet close];
    [statement close];
}
-(void)test05 {
    // -[WFDSResultSet integerForColumnAtIndex:] throws exception if the value is neither NULL nor an INTEGER.
    WFDSStatement *statement = [self.connection prepareStatement:@"SELECT 'Hello World!'"];
    WFDSResultSet *resultSet = [statement executeQuery];
    
    [resultSet next];
    XCTAssertThrows([resultSet integerForColumnAtIndex:0], @"Should throw an exception.");
    [resultSet close];
    [statement close];
}
-(void)test06 {
    // -[WFDSResultSet doubleForColumnAtIndex:] throws exception if the value is neither NULL nor a FLOAT.
    WFDSStatement *statement = [self.connection prepareStatement:@"SELECT 'Hello World!'"];
    WFDSResultSet *resultSet = [statement executeQuery];
    
    [resultSet next];
    XCTAssertThrows([resultSet doubleForColumnAtIndex:0], @"Should throw an exception.");
    [resultSet close];
    [statement close];
}
-(void)test07 {
    // Close a closed connection should be OK.
    WFDSConnection *connection = [WFDSConnection connectionForMemorySource];
    XCTAssertNoThrow([connection close], @"Should not throw.");
    XCTAssertNoThrow([connection close], @"Should not throw.");
}

@end
