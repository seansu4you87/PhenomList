//
//  PLLoadingView.m
//  PhenomList
//
//  Created by Joe Taylor on 1/23/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLLoadingView.h"
#import "PLImageHelper.h"

@implementation PLLoadingView

-(id)init
{
    UIImage *image = [PLImageHelper loadingImageForIndex:1];
    if (self = [super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)])
	{               
        NSMutableArray *images = [NSMutableArray array];
        
        for (int i = 1; i < 26; i++)
        {
            [images addObject:[PLImageHelper loadingImageForIndex:i]];
        }
        
        UIImageView *myAnimatedView = [[UIImageView alloc] initWithFrame:self.bounds];
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
