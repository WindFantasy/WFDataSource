//
//  AppField.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "AppField.h"

@implementation AppField
- (void)awakeFromNib{
    [super awakeFromNib];
    self.enabled = self.enabled;
}
-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    if (enabled) {
        self.textColor = [UIColor colorNamed:@"Link Color"];
    } else {
        self.textColor = [UIColor colorNamed:@"Disable Text Color"];
    }
}
@end
