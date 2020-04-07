//
//  AppCurrencyField.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "AppCurrencyField.h"

@implementation AppCurrencyField
- (void)awakeFromNib{
    [super awakeFromNib];
    [self addTarget:self action:@selector(actionEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(actionEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
}
-(void)setCurrency:(double)currency{
    _currency = currency;
    if (currency == 0) {
        self.text = nil;
    } else {
        self.text = [NSString stringWithFormat:@"$%0.0f", currency];
    }
}
-(void)actionEditingDidBegin:(id)sender{
    if (_currency != 0) {
        self.text = @(_currency).stringValue;
    }
}
-(void)actionEditingDidEnd:(id)sender{
    NSString *text = self.text;
    _currency = text.doubleValue;
    self.text = [NSString stringWithFormat:@"$%0.0f", _currency];
}
@end
