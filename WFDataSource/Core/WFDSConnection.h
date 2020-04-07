//
//  WFDSConnection.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 WFDConnection represents connection to SQLite database.
 */
@interface WFDSConnection : NSObject
/**
 Create a connection to a SQLite database.
 
 The method looks for the database of the 'path' and under the 'document directory' speciifed by
 'NSDocumentDirectory'. If the database file dose not exist then the method will an empty one and return its
 connection.
 
 @param path is the path to the database file related to the document directory.
 */
+(instancetype)connectionWithDocumentPath:(NSString *)path;

/// Close the receiver.
-(void)close;

/**
 Performs a transaction.
 
 Enclose the 'execution' block between 'BEGIN' and  'COMMIT' commands.
 'ROLLBACK' if received any exception from the block.
 
 @param execution is a block run between 'BEGIN' and 'COMMIT' commands.
 
 */
-(void)performTransaction:(void (^)(void))execution;
@end

@interface WFDSConnection(Stream)
/**
 Processes SQL Stream files in main bundle.
 */
-(void)processSQLStreamInMainBundle;
@end

NS_ASSUME_NONNULL_END
