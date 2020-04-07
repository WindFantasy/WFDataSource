//
//  WFDSDaoManager.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//

#import "WFDSDaoManager+Internal.h"
#import "wfdao.h"
#import "WFXmlParser.h"
#import "WFDSOperationDefinition.h"
#import "WFDSScriptAccess.h"
#import "WFDSDataAccessObject.h"
#import "WFDSInsert.h"
#import "WFDSDelete.h"
#import "WFDSUpdate.h"
#import "WFDSSelect.h"

@interface WFDSDaoManager()<WFXmlParserDelegate>
@end

@implementation WFDSDaoManager{
    WFXmlParser *_parser;
    WFDSDataAccessObject *_dao;
}
+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static WFDSDaoManager *INSTANCE;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[WFDSDaoManager alloc] init];
    });
    return INSTANCE;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        WFXChoiceBuilder *builder = [WFXChoiceBuilder builder];
        
        builder.name = @"insert";
        builder.mixed = YES;
        [builder addStringAttribute:@"selector" required:YES];
        [builder addBooleanAttribute:@"trace" required:NO];
        [builder addStringAttribute:@"table" required:NO];
        [builder addStringAttribute:@"exclude" required:NO];
        id insert = [builder build];

        builder.name = @"delete";
        builder.mixed = YES;
        [builder addStringAttribute:@"selector" required:YES];
        [builder addBooleanAttribute:@"trace" required:NO];
        id delete = [builder build];
        
        builder.name = @"update";
        builder.mixed = YES;
        [builder addStringAttribute:@"selector" required:YES];
        [builder addBooleanAttribute:@"trace" required:NO];
        [builder addStringAttribute:@"table" required:NO];
        [builder addStringAttribute:@"exclude" required:NO];
        [builder addStringAttribute:@"where" required:NO];
        id update = [builder build];
        
        builder.name = @"select";
        builder.mixed = YES;
        [builder addStringAttribute:@"selector" required:YES];
        [builder addBooleanAttribute:@"trace" required:NO];
        [builder addStringAttribute:@"type" required:NO];
        id select = [builder build];
        
        builder = [WFXChoiceBuilder builder];
        builder.name = @"dao";
        [builder addChoice:insert];
        [builder addChoice:delete];
        [builder addChoice:update];
        [builder addChoice:select];
        id dao = [builder build];
        
        _parser = [[WFXmlParser alloc] initWithValidator:dao];
        _parser.elementsToReport = @[@"insert", @"delete", @"update", @"select"];
        _parser.delegate = self;
    }
    return self;
}
-(id)instantiateDaoWithConnection:(WFDSConnection *)connection script:(NSString *)scriptName protocol:(Protocol *)protocol{
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *url = [bundle URLForResource:scriptName withExtension:@"dao.xml"];
    return [self instantiateDaoWithConnection:connection scriptURL:url protocol:protocol];
}
-(id)instantiateDaoWithConnection:(WFDSConnection *)connection scriptURL:(NSURL *)url protocol:(Protocol *)protocol{
    wfdao_info(@"Loading script '%@' ...", url.absoluteString);
    _dao = [[WFDSDataAccessObject alloc] initWithConnection:connection protocol:protocol];
    [_parser parseContentsOfURL:url];
    id dao = _dao;
    _dao = nil;
    return dao;
}
#pragma mark - WFXmlParserDelegate
-(void)parser:(WFXmlParser *)parser didEndElement:(id<WFDSScriptAccess>)element{
    static NSString *CLASS_NAMES[] = {
        ['d'] = @"WFDSDelete",
        ['i'] = @"WFDSInsert",
        ['s'] = @"WFDSSelect",
        ['u'] = @"WFDSUpdate",
    };
    
    const char *name = element.name.UTF8String;
    NSString *className = CLASS_NAMES[name[0]];
    Class c = NSClassFromString(className);
    WFDSOperation *operation = [[c alloc] initWithElement:element];
    [_dao addOperation:operation];
}
@end
