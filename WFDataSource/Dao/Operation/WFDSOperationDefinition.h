//
//  WFDSOperationDefinition.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//

#import <Foundation/Foundation.h>
#import "WFDSEntityHints.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFDSOperationDefinition : NSObject
@property (nonatomic, copy) NSString *selectorName;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) BOOL trace;
@property (nonatomic, copy) NSString *sql;
@property (nonatomic, strong) NSMethodSignature *methodSignature;

@property (nonatomic, copy) NSString *table;
@property (nonatomic, copy) NSString *exclude;
@property (nonatomic, copy) NSString *where;

@property (nonatomic, strong) WFDSEntityHints *hints;
@end

NS_ASSUME_NONNULL_END
