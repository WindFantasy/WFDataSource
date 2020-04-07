//
//  AppPageViewController.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "AppPageViewController.h"
#import "ViewAssist.h"

@interface AppPageViewController ()
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, copy) IBInspectable NSString *identifiers;
@end

@implementation AppPageViewController{
    NSArray<NSString *> *_identifierArray;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    _identifierArray = [_identifiers componentsSeparatedByString:@", "];
}
- (void)viewDidLoad{
    [self.segmentedControl addTarget:self action:@selector(actionSwitchViewController:) forControlEvents:UIControlEventValueChanged];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.selectedIndex = self.selectedIndex;
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [ViewAssist removeChildViewController:self];
    if(self.segmentedControl.selectedSegmentIndex != selectedIndex){
        self.segmentedControl.selectedSegmentIndex = selectedIndex;
    }
    id childViewController = [ViewAssist viewController:self presentViewControllerOfIdentifier:_identifierArray[selectedIndex] inView:self.containerView];
    [self didPresentViewController:childViewController];
}
-(void)actionSwitchViewController:(id)sender{
    self.selectedIndex = self.segmentedControl.selectedSegmentIndex;
}
-(void)didPresentViewController:(UIViewController *)childViewController{
    // do nothing
}
@end
