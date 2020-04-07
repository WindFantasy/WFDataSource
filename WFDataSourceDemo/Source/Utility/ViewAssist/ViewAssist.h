//
//  ViewAssist.h
//  TGIFriday
//
//  Created by Jerry on 2018/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewAssist : NSObject
+(void)viewController:(UIViewController *)parentViewController presentViewControlelr:(UIViewController *)childViewController inView:(nullable UIView *)containerView;
+(UIViewController *)viewController:(UIViewController *)parentViewController presentViewControllerOfIdentifier:(NSString *)storyboardIdentifier inView:(nullable UIView *)containerView;
+(UIViewController *)removeChildViewController:(UIViewController *)parentViewController;
@end


NS_ASSUME_NONNULL_END
