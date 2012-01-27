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

- (void)fillWithDataFromList:(PLList *)list
{
    self.dateCreated = list.dateCreated;
    self.dateUpdated = list.dateUpdated;
    
    self.title = list.title;
    self.summary = list.summary;
    
    [self.phenoms removeAllObjects];
    [self.phenoms addObjectsFromArray:list.phenoms];
}

@end
