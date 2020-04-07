//
//  BasicUpdateDao.h
//  WFDataSourceTests
//
//  Created by Jerry on 2020/1/3.
//

#import <Foundation/Foundation.h>
#import "BasicValueObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BasicUpdateDao <NSObject>
-(NSUInteger)insertRecord:(BasicValueObject *)record;
-(NSUInteger)insertRecordShortcut:(BasicValueObject *)record;
-(NSUInteger)insertRecordShortcut2:(BasicValueObject *)record;

-(NSUInteger)deleteRecord:(NSString *)identity;

-(NSUInteger)updateRecord:(BasicValueObject *)record;
-(NSUInteger)updateRecordShortcut:(BasicValueObject *)record;

-(BasicValueObject *)selectRecord;
-(BasicValueObject *)selectUnicodeRecord;
-(NSArray<BasicValueObject *> *)selectRecords;
@end

NS_ASSUME_NONNULL_END
