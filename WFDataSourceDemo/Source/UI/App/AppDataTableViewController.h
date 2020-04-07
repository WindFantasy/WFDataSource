//
//  AppDataTableViewController.h
//  WFDataSource
//
//  Created by Jerry on 2020/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDataTableViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, assign) IBInspectable BOOL separateRowColor;
@end

NS_ASSUME_NONNULL_END
