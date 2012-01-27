//
//  PLCategory.m
//  PhenomList
//
//  Created by Sean Yu on 12/21/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLList.h"

@implementation PLList

@synthesize dateCreated = date_created, dateUpdated = date_updated, title, summary, phenoms;

- (id)init
{
    if (self = [super init])
    {
        phenoms = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)fillWithDataFromList:(PLList *)list
{
    if (list.dateCreated)
        self.dateCreated = list.dateCreated;
    
    if (list.dateUpdated)
        self.dateUpdated = list.dateUpdated;
    
    if (list.title)
        self.title = list.title;
    
    if (list.summary)
        self.summary = list.summary;
    
    if ([list.phenoms count])
    {
        [self.phenoms removeAllObjects];
        [self.phenoms addObjectsFromArray:list.phenoms];
    }
}

@end
