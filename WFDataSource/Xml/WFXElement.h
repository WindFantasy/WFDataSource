//
//  WFXElement.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WFXElement <NSObject>
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSInteger level;
@property (nonatomic, readonly, copy) NSString *value;

@property (nonatomic, readonly) id<WFXElement> parent;
@property (nonatomic, readonly, copy) NSArray<id<WFXElement>> *children;
@end

NS_ASSUME_NONNULL_END
