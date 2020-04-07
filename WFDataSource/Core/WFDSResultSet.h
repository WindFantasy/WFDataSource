//
//  WFDSResultSet.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/9.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

NS_ASSUME_NONNULL_BEGIN
@class WFDSStatement;

@interface WFDSResultSet : NSObject
@property (nonatomic, readonly, weak) WFDSStatement *statement;
@property (nonatomic, readonly) NSInteger numColumn;

+(instancetype)resultSetWithStatement:(WFDSStatement *)statement;
-(void)close;

-(BOOL)next;
-(NSInteger)integerForColumnAtIndex:(NSUInteger)index;
-(double)doubleForColumnAtIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
