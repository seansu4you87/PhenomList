//
//  PLLabelHelper.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLLabelHelper.h"

@implementation PLLabelHelper

+ (CGSize)sizeForTextInLabel:(UILabel *)label withMaxSize:(CGSize)maxSize
{
    return [label.text sizeWithFont:label.font constrainedToSize:maxSize lineBreakMode:label.lineBreakMode];
}

@end
