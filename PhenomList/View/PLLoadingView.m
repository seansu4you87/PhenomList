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
        NSLog(@"HEre");
        NSArray *myImages = [NSArray arrayWithObjects: [UIImage imageNamed:@"PLLoading_01.png"], [UIImage imageNamed:@"PLLoading_02.png"], [UIImage imageNamed:@"PLLoading_03.png"], [UIImage imageNamed:@"PLLoading_04.png"], [UIImage imageNamed:@"PLLoading_05.png"], [UIImage imageNamed:@"PLLoading_06.png"], [UIImage imageNamed:@"PLLoading_07.png"], [UIImage imageNamed:@"PLLoading_08.png"], [UIImage imageNamed:@"PLLoading_09.png"], [UIImage imageNamed:@"PLLoading_10.png"], [UIImage imageNamed:@"PLLoading_11.png"], [UIImage imageNamed:@"PLLoading_12.png"], [UIImage imageNamed:@"PLLoading_13.png"], [UIImage imageNamed:@"PLLoading_14.png"], [UIImage imageNamed:@"PLLoading_15.png"], [UIImage imageNamed:@"PLLoading_16.png"], [UIImage imageNamed:@"PLLoading_17.png"], [UIImage imageNamed:@"PLLoading_18.png"], [UIImage imageNamed:@"PLLoading_19.png"], [UIImage imageNamed:@"PLLoading_20.png"], [UIImage imageNamed:@"PLLoading_21.png"], [UIImage imageNamed:@"PLLoading_22.png"], [UIImage imageNamed:@"PLLoading_23.png"], [UIImage imageNamed:@"PLLoading_24.png"], [UIImage imageNamed:@"PLLoading_25.png"], nil]; 
        
        
        UIImageView *myAnimatedView = [[UIImageView alloc] initWithFrame:frame];
        myAnimatedView.animationImages = myImages; 
        myAnimatedView.animationDuration = 4.0f; // 4 seconds 
        myAnimatedView.animationRepeatCount = 0; // 0 = loops forever 
        [myAnimatedView startAnimating];
	}
	return self;
}

@end
