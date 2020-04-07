//
//  AppButton.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/1.
//

#import "AppButton.h"

@implementation AppButton
-(void)setTheTitle:(NSString *)theTitle{
    _theTitle = theTitle;
    if (!theTitle) {
        [self setTitle:self.placeholder forState:UIControlStateNormal];
    }
    [self updateColor];
}
-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    [self updateColor];
}
-(void)updateColor{
    UIColor *color = [UIColor colorNamed:@"Disable Text Color"];
    if (self.enabled) {
        color = self.theTitle ? [UIColor colorNamed:@"Link Color"] : [UIColor colorNamed:@"Placeholder Color"];
    }
    [self setTitleColor:color forState:UIControlStateNormal];
}
@end
