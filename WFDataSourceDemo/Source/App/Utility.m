//
//  Utility.m
//  WFDataSource
//
//  Created by Jerry on 2020/5/2.
//

#import "Utility.h"


NSString *SwitchValues(NSString * const *values, NSInteger size, NSString *currentValue){
    NSString * const *ptr = values;
    for (int i = 0; i < size; i++, ptr++) {
        if ([(*ptr) isEqualToString:currentValue]) {
            return values[(i + 1) % size];
        }
    }
    return values[0];
}

UIAlertController *MakeActionSheet(NSString *title, NSString *format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    
    return [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
}

void SetupAlertActions(UIAlertController *alertController, NSArray<NSString *> *titles, NSString *cancelTitle, void(^handler)(UIAlertAction * _Nonnull action)){
    for (NSString *t in titles) {
        [alertController addAction:[UIAlertAction actionWithTitle:t style:UIAlertActionStyleDefault handler:handler]];
    }
    if (cancelTitle) {
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil]];
    }
}
