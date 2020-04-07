//
//  Utility.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *SwitchValues(NSString * _Nonnull const * _Nonnull values, NSInteger size, NSString *currentValue);
FOUNDATION_EXPORT UIAlertController *MakeActionSheet(NSString *title, NSString *format, ...) NS_FORMAT_FUNCTION(2, 3);
FOUNDATION_EXPORT void SetupAlertActions(UIAlertController *alertController, NSArray<NSString *> *titles, NSString *cancelTitle, void(^handler)(UIAlertAction * _Nonnull action));

NS_ASSUME_NONNULL_END
