//
//  PLPhenomView.m
//  PhenomList
//
//  Created by Sean Yu on 3/16/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLPhenomView.h"

#import "PLImageHelper.h"

@implementation PLPhenomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithPatternImage:[PLImageHelper tableFooterImage]];
        self.alwaysBounceVertical = YES;
        
        
    }
    return self;
}

@end
