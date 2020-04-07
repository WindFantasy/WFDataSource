//
//  Forwardable.h
//  GoodcheeApp
//
//  Created by Jerry on 2020/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Forwardable : NSObject{
    @protected
    id _target;
}

-(instancetype)initWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
