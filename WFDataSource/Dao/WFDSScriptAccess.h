//
//  WFDSScriptAccess.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//

#import <Foundation/Foundation.h>
#import "WFXElement.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WFDSScriptAccess <WFXElement>
@property (nonatomic, readonly, copy) NSString *selector;
@property (nonatomic, readonly) BOOL trace;
@property (nonatomic, readonly, copy) NSString *type;
@property (nonatomic, readonly, copy) NSString *table;
@property (nonatomic, readonly, copy) NSString *exclude;
@property (nonatomic, readonly, copy) NSString *where;
@end

NS_ASSUME_NONNULL_END
