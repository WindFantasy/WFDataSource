//
//  BasicField.h
//  WFDataSource
//
//  Created by Jerry on 2020/5/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicField : UITextField
@property (nonatomic, weak) IBOutlet UIView *theInputAccessoryView;
@property (nonatomic, weak) IBOutlet UIView *theInputView;
@end

NS_ASSUME_NONNULL_END
