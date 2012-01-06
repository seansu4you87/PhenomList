//
//  HBAFullscreenViewControllerTransitionAnimation.h
//  HBATouch
//
//  Created by Sean Yu on 4/3/11.
//  Copyright 2011 TerriblyClever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBAViewTransitionAnimation.h"

@interface HBAFullscreenViewTransitionAnimation : HBAViewTransitionAnimation 
{
    
}

+ (HBAFullscreenViewTransitionAnimation *)fullscreenTransitionAnimationOfView:(UIView *)animatedView fromView:(UIView *)sendingSuperView withAnimation:(HBAAnimation *)theAnimation sendingDelegate:(id<HBATransitionSendingDelegate>)sendingDelegate receivingDelegate:(id<HBATransitionReceivingDelegate>)receivingDelegate;


@end
