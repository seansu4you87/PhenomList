//
//  PLListDetailParser.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLParser.h"

@class PLList;
@class PLPhenom;

@interface PLListDetailParser : PLParser
{
    PLList *list;
    PLPhenom *current_phenom;
}

@end
