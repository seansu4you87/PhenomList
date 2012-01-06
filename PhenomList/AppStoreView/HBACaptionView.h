//
//  HBACaptionView.h
//  HBATouch
//
//  Created by Sean Yu on 1/23/11.
//  Copyright 2011 TerriblyClever. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HBACaptionView : UIView 
{
	UILabel *title_label;
	UILabel *subtitle_label;
}

@property(nonatomic, retain) UILabel *titleLabel, *subtitleLabel;

- (void)reframeLabels;

@end
