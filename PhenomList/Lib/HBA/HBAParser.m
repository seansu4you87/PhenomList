//
//  HBAParser.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 12/6/10.
//  Copyright 2010 Sqr11. All rights reserved.
//

#import "HBAParser.h"


@implementation HBAParser

@synthesize rawXML = raw_xml;

- (void) dealloc
{
    
}

- (void) initialize
{
	current_content = [NSMutableString stringWithCapacity:0];
	self.delegate = self;
}

- (id)initWithContentsOfURL:(NSURL *)url
{
    self = [super initWithContentsOfURL:url];
    
	if(self)
	{
		[self initialize];
	}
	
	return self;
}

- (id) initWithData:(NSData *)data
{
    self = [super initWithData:data];
    
	if(self)
	{
		[self initialize];
		raw_xml = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	}
	
	return self;
}

- (id) init
{
	self = [super init]; 
    
    if(self)
	{
		[self initialize];
	}
	
	return self;
}

#pragma mark -
#pragma mark NSXMLParserDelegate Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	[self didStartElement:elementName attributes:attributeDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	NSString * content = [[NSString stringWithString:current_content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
	
	[self didEndElement:elementName content:content];
	
	[current_content setString:@""];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[current_content appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self didEndDocument];
}

#pragma mark -
#pragma mark HBAParser subclass overrides

- (NSString*) datumTag
{
	//let subclasses implement ths
	return nil;
}

- (void) didStartElement:(NSString*)theElement attributes:(NSDictionary*)theAttributeDict
{
	//let subclasses implement this
    

}

- (void) didEndElement:(NSString*)theElement content:(NSString*)theContent
{
	//let subclasses implement this
}

- (void) didEndDocument
{
    
}


@end
