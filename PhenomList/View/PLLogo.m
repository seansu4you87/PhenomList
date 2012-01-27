//
//  PLLogo.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLLogo.h"
#import "PLImageHelper.h"

@implementation PLLogo

+ (PLLogo *)logo
{
    return [[PLLogo alloc] initWithImage:[PLImageHelper logoImage]];
}

@end
