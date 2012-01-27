//
//  PLListDetailParser.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLListDetailParser.h"
#import "PLApplicationData.h"
#import "PLList.h"
#import "PLPhenom.h"

#import "PLDateHelper.h"

@implementation PLListDetailParser

- (id)initWithData:(NSData *)data
{
    if (self = [super initWithData:data])
    {
        list = [[PLList alloc] init];
    }
    return self;
}

#pragma mark - 
#pragma mark Method Overrides

- (void) didStartElement:(NSString*)theElement attributes:(NSDictionary*)theAttributeDict
{
    if ([theElement isEqualToString:@"person"])
    {
        current_phenom = [[PLPhenom alloc] init];
    }
}

- (void) didEndElement:(NSString*)theElement content:(NSString*)theContent
{
    if ( [theElement isEqualToString:@"id"])
    {
        if (current_phenom)
            current_phenom.uid = [theContent intValue];
        else
            list.uid = [theContent intValue];
    }
    
    if ( [theElement isEqualToString:@"summary"] )
        list.summary = theContent;
    
    if ( [theElement isEqualToString:@"article-date"] )
    {
        NSDateFormatter *formatter = [PLDateHelper dateFormatter];
        [formatter setDateFormat:@"MM'/'dd'/'yyyy"];
        
        current_phenom.date = [formatter dateFromString:theContent];
    }
    
    if ( [theElement isEqualToString:@"content"] )
        current_phenom.content = theContent;
    
    if ( [theElement isEqualToString:@"name"] )
        current_phenom.name = theContent;
    
    if ( [theElement isEqualToString:@"lead"] )
        current_phenom.lead = theContent;
        
    if ( [theElement isEqualToString:@"person"] )
        [list.phenoms addObject:current_phenom];
    
//    if ( [theElement isEqualToString:@"created-at"] )
        
    
    
}

#pragma mark - 
#pragma mark Setters and Getters

- (id)data
{
    return list;
}


@end
