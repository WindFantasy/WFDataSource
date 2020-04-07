//
//  WFXmlParser.h
//  WFDataSource
//
//  Created by Jerry on 2019/12/6.
//  Copyright © 2019 Wind Fant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFXChoiceBuilder.h"
#import "WFXElement.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WFXmlParserDelegate;

@interface WFXmlParser : NSObject
@property (nonatomic, weak) id<WFXmlParserDelegate> delegate;
@property (nonatomic, strong) NSArray<NSString *> *elementsToReport;

-(instancetype)initWithValidator:(id<WFXValidator>)validator;
-(id<WFXElement>)parseContentsOfURL:(NSURL *)url;
@end

@protocol WFXmlParserDelegate <NSObject>
@optional
-(void)parser:(WFXmlParser *)parser didEndElement:(id<WFXElement>)element;
@end

NS_ASSUME_NONNULL_END
