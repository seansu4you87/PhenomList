//
//  HBAFullscreenViewControllerTransitionAnimation.m
//  HBATouch
//
//  Created by Sean Yu on 4/3/11.
//  Copyright 2011 TerriblyClever. All rights reserved.
//

#import "HBAFullscreenViewTransitionAnimation.h"


@implementation HBAFullscreenViewTransitionAnimation

+ (HBAFullscreenViewTransitionAnimation *)fullscreenTransitionAnimationOfView:(UIView *)animatedView fromView:(UIView *)sendingSuperView withAnimation:(HBAAnimation *)theAnimation sendingDelegate:(id<HBATransitionSendingDelegate>)sendingDelegate receivingDelegate:(id<HBATransitionReceivingDelegate>)receivingDelegate
{
    HBAFullscreenViewTransitionAnimation *result = [[HBAFullscreenViewTransitionAnimation alloc] initWithView:animatedView fromView:sendingSuperView toView:[HBAViewTransitionAnimation mainWindow] withAnimation:theAnimation sendingDelegate:sendingDelegate receivingDelegate:receivingDelegate];
    return result;
}

- (void)fire
{
    if (![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(fire) withObject:nil waitUntilDone:YES];
        return;
    }
    
    //[self removeViewFromSender];
}

@end
