//
//  Forwardable.m
//  GoodcheeApp
//
//  Created by Jerry on 2020/2/28.
//

#import "Forwardable.h"

@interface Forwardable()
@property (nonatomic, readonly) id target;
@end

@implementation Forwardable
-(instancetype)initWithTarget:(id)target{
    self = [super init];
    if (self) {
        NSAssert(target, nil);
        _target = target;
    }
    return self;
}
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if ([_target respondsToSelector:aSelector]) {
        return _target;
    }
    return nil;
}
-(id)valueForUndefinedKey:(NSString *)key{
    SEL selector = NSSelectorFromString(key);
    if ([_target respondsToSelector:selector]) {
        return [_target valueForKey:key];
    }else{
        return [super valueForUndefinedKey:key];
    }
}
- (id)target{
    return _target;
}
@end
