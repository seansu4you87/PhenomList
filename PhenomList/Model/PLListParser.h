//
//  PLListParser.h
//  PhenomList
//
//  Created by Sean Yu on 12/24/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLParser.h"

@class PLList;

@interface PLListParser : PLParser
{
    NSMutableArray  *lists;
    PLList          *current_list;
}

@end
