//
//  PLPhenomButton.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLPhenomButton.h"

#import "PLImageHelper.h"

@implementation PLPhenomButton

- (id)init
{
    if (self = [super init])
    {
        [self setBackgroundImage:[PLImageHelper listCellSelectedImage] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        self.titleLabel.numberOfLines = 2;
    }
    return self;
}

@end
