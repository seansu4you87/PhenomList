//
//  PLListParser.m
//  PhenomList
//
//  Created by Sean Yu on 12/24/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLListParser.h"
#import "PLList.h"

#import "PLDateHelper.h"

@implementation PLListParser

- (id)initWithData:(NSData *)data
{
    if (self = [super initWithData:data])
    {
        lists = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - 
#pragma mark Method Overrides

- (void) didStartElement:(NSString*)theElement attributes:(NSDictionary*)theAttributeDict
{
    if ([theElement isEqualToString:@"list"])
        current_list = [[PLList alloc] init];
}

- (void) didEndElement:(NSString*)theElement content:(NSString*)theContent
{
    if ([theElement isEqualToString:@"list"])
        [lists addObject:current_list];
    
    if ([theElement isEqualToString:@"id"])
        current_list.uid = [theContent intValue];
    
    if ([theElement isEqualToString:@"summary"])
        current_list.summary = theContent;
    
    if ([theElement isEqualToString:@"title"])
        current_list.title = theContent;
    
    if ([theElement isEqualToString:@"created-at"])
    {
        NSDateFormatter *formatter = [PLDateHelper dateFormatter];
        current_list.dateCreated = [formatter dateFromString:theContent];
    }
    
    if ([theElement isEqualToString:@"updated-at"])
    {
        NSDateFormatter *formatter = [PLDateHelper dateFormatter];
        current_list.dateUpdated = [formatter dateFromString:theContent];
    }
}

#pragma mark - 
#pragma mark Setters and Getters

- (id)data
{
    return [lists sortedArrayUsingComparator:^(id obj1, id obj2){
        
        return [[obj2 dateCreated] compare:[obj1 dateCreated]];
        
    }];
}

@end
