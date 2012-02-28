//
//  PLLargePhotoArray.m
//  PhenomList
//
//  Created by Joe Taylor on 2/20/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLLargePhotoArrayView.h"
#import "PLImageHelper.h"
#import "PLPhotoFrameImageView.h"

@implementation PLLargePhotoArrayView
@synthesize imageUrls = image_Urls;

#pragma mark - View lifecycle

//initWithImageUrls:
-(id)initWithURLs: (NSArray *)photos
{
    if (self = [super initWithFrame:CGRectZero] )
	{
        imageViews = [[NSMutableArray alloc] init];
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
            [imageViews addObject:photoFrameView];
        }
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}

//Setter
-(void)setImageUrls:(NSMutableArray *)imageUrls
{
  //run for loop method from here??  

    for (PLPhotoFrameImageView *view in imageViews)
    {
        view.image = [UIImage imageNamed:@"my bs image"];
    }
}

@end
