//
//  AppStaticFormTableViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppStaticFormTableViewController : UITableViewController
@property (nonatomic, assign) BOOL editable;

-(void)refreshFields;
@end

NS_ASSUME_NONNULL_END
