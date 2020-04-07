//
//  AppDateField.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/3.
//

#import "AppDateField.h"

@interface AppDateField()
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@end

@implementation AppDateField{
    UIView *_theView;
}
+(NSDateFormatter *)dateFormatter{
    static NSDateFormatter *FORMATTER;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FORMATTER = [[NSDateFormatter alloc] init];
        FORMATTER.dateFormat = @"MMM dd, yyyy";
    });
    return FORMATTER;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [[UINib nibWithNibName:@"AppDateField" bundle:nil] instantiateWithOwner:self options:NULL];
}
-(void)setTheInputView:(UIView *)theInputView{
    [super setTheInputView:theInputView];
    _theView = theInputView;    // Strong reference to avoid auto release;
}
-(void)setDate:(NSDate *)date{
    _date = date;
    if (date) {
        self.datePicker.date = date;
    }
    self.text = [[AppDateField dateFormatter] stringFromDate:date];
}
#pragma mark - Actions
-(IBAction)actionSetDate:(UIDatePicker *)sender{
    self.date = sender.date;
}
@end
