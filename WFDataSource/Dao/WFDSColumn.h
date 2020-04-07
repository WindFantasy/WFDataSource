//
//  WFDSColumn.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WFPropertyType) {
    WFPropertyBoolean,
    WFPropertyInteger,
    WFPropertyFloat,
    WFPropertyText,
    WFPropertyDate,
};

@interface WFDSColumn : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) WFPropertyType type;
@end

NS_ASSUME_NONNULL_END
