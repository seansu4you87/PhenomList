//
//  HBAPaginatedInnerFullScreenTransitionManager.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/28/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HBAPaginatedScrollView;

@interface HBAPaginatedInnerFullScreenTransitionManager : NSObject {
    UIView * previous_superview;
    
    CGRect previous_local_frame;
    CGRect previous_local_bounds;
    CGAffineTransform previous_local_transform;
    CGPoint previous_center;
    
    CGRect previous_window_frame;
    int previous_subview_index;
    
    
    UIView * shade_view;
    HBAPaginatedScrollView * animated_view;
}

@property(nonatomic, retain) UIView * previousSuperView;

- (void) initiateFullScreenEntryOfView:(HBAPaginatedScrollView*)theAnimatedView;
- (void) initiateFullScreenExit;

@end
