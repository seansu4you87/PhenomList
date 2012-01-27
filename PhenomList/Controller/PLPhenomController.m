//
//  PLPhenomController.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLPhenomController.h"
#import "PLPhenom.h"

@implementation PLPhenomController

- (id)initWithPhenom:(PLPhenom *)thePhenom
{
    if (self = [super init])
    {
        phenom = thePhenom;
        
        self.title = phenom.name;
    }
    return self;
}

@end
