//
//  HBAPaginatedPageView.h
//  HBATouch
//
//  Created by Sean Yu on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBAContentMode.h"

@class HBAAnimation;

@interface HBAPaginatedPageView : UIView 
{
	CGFloat top_margin;
	CGFloat bottom_margin;
	CGFloat left_margin;
	CGFloat right_margin;
    
	UIView *content_view;
    UIView *container_view;
	
	HBAContentModeType hba_content_mode_type;
	
	UIImageView *drop_shadow;
}

@property(nonatomic, assign) CGFloat topMargin, bottomMargin, leftMargin, rightMargin;
@property(nonatomic, retain) UIView *contentView;
@property(nonatomic, readonly) UIView *containerView;
@property(nonatomic, assign) HBAContentModeType hbaContentModeType;

- (HBAAnimation *)sizeChangeAnimationForNewFrame:(CGRect)newFrame;
- (CGRect)containerFrame;

@end
