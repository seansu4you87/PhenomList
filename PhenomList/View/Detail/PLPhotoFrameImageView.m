//
//  PLPhotoFrameImageView.m
//  PhenomList
//
//  Created by Sean Yu on 2/28/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLPhotoFrameImageView.h"

@implementation PLPhotoFrameImageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    image_view.image = image;
}

@end
