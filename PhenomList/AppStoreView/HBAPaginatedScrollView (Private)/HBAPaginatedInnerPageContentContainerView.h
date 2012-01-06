//
//  HBAPaginatedInnerPageContentContainerView.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/27/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HBAPaginatedInnerPageContentContainerView : UIView {
    UIView * content_view;
    CGSize desired_content_size;
    
    UIViewContentMode content_content_mode;
}

@property(nonatomic, retain) UIView * contentView;
@property(nonatomic, assign) UIViewContentMode contentContentMode;
@property(nonatomic, assign) CGSize desiredContentSize;

@end
