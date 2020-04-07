//
//  WFDSStreamProcessor.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFDSStreamProcessor.h"
#import "wfds.h"
#import "WFXmlParser.h"
#import "WFDSConnection+Internal.h"

@interface WFDSStreamProcessor()<WFXmlParserDelegate>
@property (nonatomic, readonly) WFDSConnection *connection;
@end

@implementation WFDSStreamProcessor{
    WFXmlParser *_parser;
}
+(instancetype)sharedProcessor{
    static WFDSStreamProcessor *INSTANCE;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[WFDSStreamProcessor alloc] init];
    });
    return INSTANCE;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        WFXChoiceBuilder *builder = [WFXChoiceBuilder builder];
        builder.name = @"statement";
        builder.mixed = YES;
        id statement = [builder build];
        
        builder = [WFXChoiceBuilder builder];
        builder.name = @"execute";
        [builder addChoice:statement];
        id batch = [builder build];
        
        _parser = [[WFXmlParser alloc] initWithValidator:batch];
        _parser.elementsToReport = @[@"statement"];
        _parser.delegate = self;
    }
    return self;
}
-(void)connection:(WFDSConnection *)connection processBatchInBundle:(NSBundle *)bundle{
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    wfds_info(@"Processing batch files (%@) ...", bundle.bundlePath);
    
    NSInteger version = wfds_getUserVersion(connection);
    
    NSArray<NSString *> *paths = [bundle pathsForResourcesOfType:@"stream.xml" inDirectory:nil];
    paths = [paths sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"SELF" ascending:YES]]];
    
    NSInteger v = 0;
    for (NSString *p in paths) {
        v = p.lastPathComponent.stringByDeletingPathExtension.integerValue;
        if (v > version) {
            [self connection:connection process:p];
        }
    }
    wfds_setUserVersion(connection, v);
}
-(void)connection:(WFDSConnection *)connection process:(NSString *)path{
    _connection = connection;
    NSURL *url = [NSURL fileURLWithPath:path];
    @try {
        [_connection begin];
        [_parser parseContentsOfURL:url];
        [_connection commit];
    } @catch (NSException *exception) {
        [_connection rollback];
        @throw exception;
    }
}
#pragma mark - WFXmlParserDelegate
-(void)parser:(WFXmlParser *)parser didEndElement:(id<WFXElement>)element{
    [_connection execute:element.value];
}
@end
