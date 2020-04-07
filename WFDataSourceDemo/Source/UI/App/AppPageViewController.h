//
//  AppPageViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppPageViewController : UIViewController
@property (nonatomic, assign) NSUInteger selectedIndex;

-(void)didPresentViewController:(UIViewController *)childViewController;
@end

NS_ASSUME_NONNULL_END
