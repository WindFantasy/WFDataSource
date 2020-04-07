//
//  AppTextView.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "AppTextView.h"

@implementation AppTextView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.editable = self.editable;
}
-(void)setEditable:(BOOL)editable{
    [super setEditable:editable];
    self.textColor = editable ? [UIColor colorNamed:@"Link Color"] : [UIColor colorNamed:@"Disable Text Color"];
}
@end
