//
//  PLParser.m
//  PhenomList
//
//  Created by Sean Yu on 12/24/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLParser.h"

@implementation PLParser

- (id)initWithData:(NSData *)data
{
    if (self = [super initWithData:data])
    {
        //NSLog(@"%@ Data\n%@", NSStringFromClass([self class]), [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }
    return self;
}

- (id)data
{
    return nil;
}

@end
