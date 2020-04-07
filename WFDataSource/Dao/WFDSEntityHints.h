//
//  WFDSEntityHints.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An entity hint is for guiding a conversion process from a result set to an (or array of) entity object.
 
 The major part the hint is an array of column information. That including:
 
 - The columns invoked in the convertion
 
 - The referred properties of the entity
 
 - And their result set index indexes.
 */
@interface WFDSEntityHints : NSObject
@property (nonatomic, strong) Class targetClass;
@property (nonatomic, assign) BOOL singleTarget;
@end

NS_ASSUME_NONNULL_END
