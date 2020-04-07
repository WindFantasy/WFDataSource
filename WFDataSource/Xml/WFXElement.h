//
//  WFXElement.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WFXElement <NSObject>
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger level;
@property (nonatomic, readonly) NSString *value;

@property (nonatomic, readonly) id<WFXElement> parent;
@property (nonatomic, readonly) NSArray<id<WFXElement>> *children;
@end

NS_ASSUME_NONNULL_END
