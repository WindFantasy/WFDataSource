//
//  WFDSOperationDefinition.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFDSEntityHints.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFDSOperationDefinition : NSObject
@property (nonatomic, strong) NSString *selectorName;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) BOOL trace;
@property (nonatomic, strong) NSString *sql;
@property (nonatomic, strong) NSMethodSignature *methodSignature;

@property (nonatomic, strong) NSString *table;
@property (nonatomic, strong) NSString *exclude;
@property (nonatomic, strong) NSString *where;

@property (nonatomic, strong) WFDSEntityHints *hints;
@end

NS_ASSUME_NONNULL_END
