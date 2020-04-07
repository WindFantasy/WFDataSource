//
//  WFDSDataAccessObject.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/21.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFDSDataAccessObject.h"
#import "WFDSScriptAccess.h"
#import <objc/runtime.h>
#import "WFDSOperation+Internal.h"
#import "wfdao.h"

@interface WFDSDataAccessObject()
@end

@implementation WFDSDataAccessObject{
    NSMutableDictionary<NSString *, WFDSOperation *> *_operations;
}
-(instancetype)initWithConnection:(WFDSConnection *)connection protocol:(Protocol *)protocol{
    self = [super init];
    if (self) {
        _connection = connection;
        _protocol = protocol;
        _operations = [NSMutableDictionary dictionary];
    }
    return self;
}
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    struct objc_method_description methodDescription = protocol_getMethodDescription(self.protocol, aSelector, YES, YES);
    return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    NSString *selectorName = NSStringFromSelector(anInvocation.selector);
    WFDSOperation *operation = _operations[selectorName];
    if (!operation) {
        @throw wfdao_exception(nil, @"Definition not found.");
    }
    @synchronized (_connection) {
        [operation performInvocation:anInvocation];
    }
}
-(void)addOperation:(WFDSOperation *)operation{
    NSString *selectorName = operation.definition.selectorName;
    
    wfdao_infoB(self, @"Preparing operation '%@' ...", selectorName);
    struct objc_method_description methodDescription = protocol_getMethodDescription(self.protocol, operation.definition.selector, YES, YES);
    if (methodDescription.types == NULL) {
        wfdao_infoB(self, @"Omit. Protocol '%@' has no selector named '%@'.", NSStringFromProtocol(self.protocol), selectorName);
        return;
    }
    operation.dao = self;
    _operations[selectorName] = operation;
    wfdao_infoB(self, @"Prepare operation '%@' done.", selectorName);
}
@end
