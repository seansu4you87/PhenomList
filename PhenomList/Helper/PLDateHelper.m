//
//  PLDateHelper.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLDateHelper.h"

@implementation PLDateHelper


NSDateFormatter *dateFormatter;
+ (NSDateFormatter *)dateFormatter
{
    if (dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        
    }
    return dateFormatter;
}

@end
