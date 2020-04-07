//
//  WFXmlParser.m
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import "WFXmlParser+Internal.h"
#import "wfxsd.h"
#import "WFXDocument.h"

@interface WFXmlParser()<NSXMLParserDelegate>
@property (nonatomic, strong) WFXElementValidator *validator;
@property (nonatomic, strong) WFXDocument *document;
@end

@implementation WFXmlParser{
    NSSet<NSString *> *_reportSet;
}
-(instancetype)initWithValidator:(id<WFXValidator>)validator{
    self = [super init];
    if (self) {
        if (![validator isKindOfClass:[WFXElementValidator class]]) {
            @throw wfx_exception(nil, @"WFXValidator MUST built by a WFXBuilder.");
        }
        _validator = validator;
    }
    return self;
}
-(id<WFXElement>)parseContentsOfURL:(NSURL *)url{
    static dispatch_queue_t _reentrantAvoidanceQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _reentrantAvoidanceQueue = dispatch_queue_create("reentrantAvoidanceQueue", DISPATCH_QUEUE_SERIAL);
    });
    _url = url;
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    _parser.shouldProcessNamespaces = NO;
    _parser.delegate = self;
    _document = [[WFXDocument alloc] initWithValidator:_validator parser:self];
    if(![self->_parser parse]){
        @throw wfx_exception(self, @"Parse failed.");
    }
    id tmp = _document.root;
    _document = nil;
    return tmp;
}
-(void)setElementsToReport:(NSArray<NSString *> *)elementsToReport{
    _elementsToReport = elementsToReport;
    _reportSet = [NSSet setWithArray:elementsToReport];
}
#pragma mark - NSXMLParserDelegate
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    wfx_info(self, @"Processing '%@' ...", self.url.lastPathComponent);
}
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    wfx_info(self, @"Process done.");
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    [_document startElement:elementName];
    [_document processAttributes:attributeDict];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    id element = [_document endElement:elementName];
    if ((_elementsToReport == nil || [_reportSet containsObject:elementName]) && [self.delegate respondsToSelector:@selector(parser:didEndElement:)]) {
        [self.delegate parser:self didEndElement:element];
    }
}
-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    [_document processCDATA:CDATABlock];
}
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    @throw wfx_exception(self, @"Parse failed. %@", parseError.localizedDescription);
}
@end
