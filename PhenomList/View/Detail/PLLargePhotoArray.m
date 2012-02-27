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
-(id)initWithURLs: (NSArray *)photos
{
    if (self = [super initWithFrame:CGRectZero] )
	{
        
        for (int i = [photos count]; i > 0; i--)
        {
            NSString *imageURL = [photos objectAtIndex:(i-1)];
            
            UIImageView *photoFrameView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            //photoFrameView.backgroundColor = [UIColor colorWithPatternImage:[PLImageHelper largePhotoFrame]];
            
            photoFrameView.image = [PLImageHelper largePhotoFrame];
            
            switch (i) {
                case 5:
                photoFrameView.transform = CGAffineTransformMakeRotation(M_PI / 36.0);
                break;

                case 4:
                photoFrameView.transform = CGAffineTransformMakeRotation(M_PI / -36.0);
                break;

                case 3:
                photoFrameView.transform = CGAffineTransformMakeRotation(M_PI / 18.0);
                break;

                case 2:
                photoFrameView.transform = CGAffineTransformMakeRotation(M_PI / -18.0);
                break;

            }
             
             
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
