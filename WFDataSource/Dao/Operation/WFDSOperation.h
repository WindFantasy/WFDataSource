//
//  WFDSOperation.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//

#import <Foundation/Foundation.h>
#import "WFDSOperationDefinition.h"
#import "WFDSDataAccessObject.h"
#import "WFDSStatement.h"
#import "WFDSScriptAccess.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFDSOperation : NSObject
@property (nonatomic, readonly, weak) WFDSDataAccessObject *dao;
@property (nonatomic, readonly, strong) WFDSOperationDefinition *definition;

-(instancetype)initWithElement:(id<WFDSScriptAccess>)element;
-(void)performInvocation:(NSInvocation *)invocation;
-(void)statement:(WFDSStatement *)statement bindParametersWithArgumentsFromInvocation:(NSInvocation *)invocation;
@end

NS_ASSUME_NONNULL_END
