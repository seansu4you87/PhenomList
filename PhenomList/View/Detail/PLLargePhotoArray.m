//
//  PLLargePhotoArray.m
//  PhenomList
//
//  Created by Joe Taylor on 2/20/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLLargePhotoArray.h"
#import "PLImageHelper.h"

@implementation PLLargePhotoArray


#pragma mark - View lifecycle

//initWithImageUrls:
-(id)initWithImages: (NSArray *)photos
{
    if (self = [super initWithFrame:CGRectZero] )
	{
        for (int i = 0; i < [photos count]; i++)
        {
            NSString *imageURL = [photos objectAtIndex:i];
            
            //TODO:make it an imageview.  
            
            UIView *photoFrameView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            photoFrameView.backgroundColor = [UIColor colorWithPatternImage:[PLImageHelper largePhotoFrame]];
            
            photoFrameView.transform = CGAffineTransformMakeRotation(M_PI / 18.0);
            
            [self addSubview:photoFrameView];
        }
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}



@end
