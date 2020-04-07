//
//  AppButton.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppButton : UIButton
@property (nonatomic, copy) IBInspectable NSString *placeholder;

@property (nonatomic, copy) NSString *theTitle;
@end

NS_ASSUME_NONNULL_END
