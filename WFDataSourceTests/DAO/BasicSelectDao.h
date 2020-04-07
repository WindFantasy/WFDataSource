//
//  DaoBasic.h
//  WFDataSourceTests
//
//  Created by Jerry on 2019/12/21.
//

#import <Foundation/Foundation.h>
#import "BasicValueObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BasicSelectDao <NSObject>
-(NSString *)selectHelloWorld;
-(NSString *)selectUnicode;
-(NSInteger)selectNumber;
-(double)selectDecimal;
-(NSDate *)selectDate;
-(BOOL)selectTrue;
-(BasicValueObject *)selectRecord;

-(BOOL)selectBoolean:(BOOL)value;
-(NSInteger)selectNumber:(NSInteger)value;
-(double)selectDecimal:(double)value;
-(NSString *)selectText:(nullable NSString *)value;
-(NSDate *)selectDate:(nullable NSDate *)value;
-(BasicValueObject *)selectRecord:(BasicValueObject *)object;
-(BasicValueObject *)selectRecordWithBoolean:(BOOL)boolean number:(NSInteger)number decimal:(double)decimal text:(NSString *)text date:(NSDate *)date;

-(NSArray<BasicValueObject *> *)selectRecords;
@end

NS_ASSUME_NONNULL_END
