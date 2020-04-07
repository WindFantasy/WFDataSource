//
//  WFDSScriptAccess.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFXElement.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WFDSScriptAccess <WFXElement>
@property (nonatomic, readonly) NSString *selector;
@property (nonatomic, readonly) BOOL trace;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *table;
@property (nonatomic, readonly) NSString *exclude;
@property (nonatomic, readonly) NSString *where;
@end

NS_ASSUME_NONNULL_END
