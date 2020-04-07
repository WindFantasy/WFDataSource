//
//  WFDSOperation+Internal.h
//  WFDataSource
//
//  Created by Jerry on 2020/1/3.
//  Copyright © 2020 Wind Fant. All rights reserved.
//
#import "WFDSOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFDSOperation ()
@property (nonatomic, weak, readwrite) WFDSDataAccessObject *dao;

+(NSSet<NSString *> *)connection:(WFDSConnection *)connection columnLabelsForTable:(NSString *)table exclude:(NSString *)exclude;
@end

NS_ASSUME_NONNULL_END
