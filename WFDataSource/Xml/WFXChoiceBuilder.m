//
//  WFXChoiceBuilder.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import "WFXChoiceBuilder.h"
#import "WFXElementValidator.h"
#import "WFXOccurrence.h"

@implementation WFXChoiceBuilder{
    NSMutableDictionary<NSString *, WFXOccurrence *> *_choices;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _choices = [NSMutableDictionary dictionary];
    }
    return self;
}
-(void)addChoice:(WFXElementValidator *)validator{
    WFXOccurrence *settings = [[WFXOccurrence alloc] init];
    settings.validator = validator;
    _choices[validator.name] = settings;
}
-(id<WFXValidator>)build{
    WFXElementValidator *validator = [super build];
    validator.choices = _choices;
    return validator;
}
@end
