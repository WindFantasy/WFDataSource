//
//  DaoAdditionalDao.h
//  WFDataSourceTests
//
//  Created by Jerry on 2020/1/5.
//

#import <Foundation/Foundation.h>
#import "BasicValueObject.h"
#import "ValueObjectA.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DaoAdditionalDao <NSObject>
-(NSUInteger)insertRecord:(BasicValueObject *)record;
-(NSUInteger)insertRecordWithNumber:(NSInteger)number decimal:(double)decimal;
-(NSUInteger)insertRecord1:(ValueObjectA *)record;
-(NSUInteger)insertRecord2:(ValueObjectA *)record;
-(NSUInteger)insertRecord3:(BasicValueObject *)record;

-(NSUInteger)updateRecord:(BasicValueObject *)record;

-(double)selectDecimal:(float)decimal;
-(float)selectDecimal;
-(BasicValueObject *)selectRecord;
-(NSString *)selectNoRow;
-(NSString *)selectTooManyColumns;
-(BasicValueObject *)selectEntityButNoRow;
-(BasicValueObject *)selectColumnsWithRepeatedLabel;
-(BasicValueObject *)selectNotExistProperty;
-(ValueObjectA *)selectReadonlyProperty;
-(ValueObjectA *)selectIncompatibleProperty;
-(ValueObjectA *)selectIncompatibleProperty2;
-(NSString *)selectNoDefinition;
@end

NS_ASSUME_NONNULL_END
