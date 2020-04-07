//
//  ViewAssist.m
//  TGIFriday
//
//  Created by Jerry on 2018/12/20.
//

#import "ViewAssist.h"

@implementation ViewAssist
+(void)view:(UIView *)parentView addView:(UIView *)childView{
    childView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addSubview:childView];
    id views = NSDictionaryOfVariableBindings(childView);
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[childView]-0-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[childView]-0-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:views]];
}
+(void)viewController:(UIViewController *)parentViewController presentViewControlelr:(UIViewController *)childViewController inView:(UIView *)containerView{
    if (!containerView) {
        containerView = parentViewController.view;
    }
    [self view:containerView addView:childViewController.view];
    [parentViewController addChildViewController:childViewController];
    [childViewController didMoveToParentViewController:parentViewController];
}
+(UIViewController *)viewController:(UIViewController *)parentViewController presentViewControllerOfIdentifier:(NSString *)storyboardIdentifier inView:(UIView *)containerView{
    UIViewController *childViewController = [parentViewController.storyboard instantiateViewControllerWithIdentifier:storyboardIdentifier];
    [self viewController:parentViewController presentViewControlelr:childViewController inView:containerView];
    return childViewController;
}
+(UIViewController *)removeChildViewController:(UIViewController *)parentViewController{
    NSAssert(parentViewController.childViewControllers.count <= 1, nil);
    if (parentViewController.childViewControllers.count == 1) {
        UIViewController *childViewController = parentViewController.childViewControllers[0];
        [childViewController beginAppearanceTransition:NO animated:YES];
        [childViewController willMoveToParentViewController:nil];
        [childViewController.view removeFromSuperview];
        [childViewController removeFromParentViewController];
        [childViewController endAppearanceTransition];
        return childViewController;
    }
    return nil;
}
@end

