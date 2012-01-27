//
//  HBAParser.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 12/6/10.
//  Copyright 2010 Sqr11. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HBAParser : NSXMLParser<NSXMLParserDelegate> {
	NSMutableString * current_content;
	NSString *raw_xml;
}

@property(nonatomic, readonly) NSString *rawXML;

#pragma mark -
#pragma mark HBAParser subclass overrides

- (void) initialize;
- (NSString*) datumTag;

- (void) didStartElement:(NSString*)theElement attributes:(NSDictionary*)theAttributeDict;
- (void) didEndElement:(NSString*)theElement content:(NSString*)theContent;
- (void) didEndDocument;

@end
