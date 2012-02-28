//
//  PLPhotoFrameImageView.h
//  PhenomList
//
//  Created by Sean Yu on 2/28/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLPhotoFrameImageView : UIView
{
    UIImageView *photo_frame_view;
    UIImageView *image_view;
}

@property(nonatomic) UIImage *image;

@end
