//
//  wfdao.m
//  WFDataSource
//
//  Created by Jerry on 2020/1/4.
//

#import "wfdao.h"

void wfdao_info(NSString * format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSLog(@"[WF][DS] - %@", message);
}
void wfdao_infoA(WFDSOperation *operation, NSString * format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSLog(@"[WF][DS][%@ %@] - %@", NSStringFromProtocol(operation.dao.protocol), operation.definition.selectorName, message);
}
void wfdao_infoB(WFDSDataAccessObject *dao, NSString * format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSLog(@"[WF][DS][%@] - %@", NSStringFromProtocol(dao.protocol), message);
}
NSException *wfdao_exception(WFDSOperation *operation, NSString *format, ...){
    va_list ap;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    NSString *reason;
    if (operation) {
        reason = [NSString stringWithFormat:@"[WF][DS][ERROR][%@ %@] - %@", NSStringFromProtocol(operation.dao.protocol), operation.definition.selectorName, message];
    } else {
        reason = [NSString stringWithFormat:@"[WF][DS][ERROR] - %@", message];
    }
    return [NSException exceptionWithName:@"NSException" reason:reason userInfo:nil];
}

NSString *wfds_toCamel(const char *underScore){
    char buf[1024];
    int i = 0;
    for (const char *c = underScore; *c != '\0'; c++, i++) {
        if (*c == '_') {
            c++;
            buf[i] = toupper(*c);
        } else {
            buf[i] = *c;
        }
    }
    buf[i] = '\0';
    return @(buf);
}
