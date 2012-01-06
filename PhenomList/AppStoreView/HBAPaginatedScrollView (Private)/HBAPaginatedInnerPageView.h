//
//  HBAPaginatedInnerPageView.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/27/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBAPaginatedInnerPageContentContainerView;

@interface HBAPaginatedInnerPageView : UIView {
    UIEdgeInsets margins;
    
    HBAPaginatedInnerPageContentContainerView * container_view;
}

@property(nonatomic, assign) UIEdgeInsets margins;
@property(nonatomic, assign) UIViewContentMode contentContentMode;
@property(nonatomic, retain) UIView * contentView;

@end
