//
//  BasicField.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/1.
//

#import "BasicField.h"

@implementation BasicField

- (void)awakeFromNib{
    [super awakeFromNib];
    self.inputAccessoryView = self.theInputAccessoryView;
    self.inputView = self.theInputView;
}
@end
