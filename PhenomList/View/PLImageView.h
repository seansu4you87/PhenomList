//
//  PLImageView.h
//  PhenomList
//
//  Created by Sean Yu on 1/31/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLImageView : UIView
{
	UIImageView *image_view;
	
	NSURL *image_url;
}

- (id)initWithImageUrl:(NSURL *)imageUrl;

@end
