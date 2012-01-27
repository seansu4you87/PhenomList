//
//  PLLoadingView.m
//  PhenomList
//
//  Created by Joe Taylor on 1/23/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLLoadingView.h"

@implementation PLLoadingView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{                
        NSMutableArray *images = [NSMutableArray array];
        
        for (int i = 1; i < 26; i++)
        {
            NSString *numString = (i < 10) ? @"0%i" : @"%i";
            numString = [NSString stringWithFormat:numString, i];
            
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"PLLoading_%@", numString]]];
        }
        
            
        
        UIImageView *myAnimatedView = [[UIImageView alloc] initWithFrame:frame];
        myAnimatedView.animationImages = images; 
        myAnimatedView.animationDuration = 1.0f; // 4 seconds 
        myAnimatedView.animationRepeatCount = 0; // 0 = loops forever 
        myAnimatedView.contentMode = UIViewContentModeBottomLeft;
        [self addSubview:myAnimatedView];

        [myAnimatedView startAnimating];
	}
	return self;
}

@end
