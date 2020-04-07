//
//  WFDSEntityHints+Internal.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/23.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFDSEntityHints.h"
#import "WFDSColumn.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFDSEntityHints (){
    @package
    BOOL _prepared;
    NSMutableArray<WFDSColumn *> *_columns;
}
@end

NS_ASSUME_NONNULL_END
