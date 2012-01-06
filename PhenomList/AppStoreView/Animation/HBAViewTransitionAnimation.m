//
//  HBAViewControllerTransitionAnimation.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 2/7/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAViewTransitionAnimation.h"


@implementation HBAViewTransitionAnimation

@synthesize animation, transitionDelegate = transition_delegate, completionBlock = completion_block;

- (void) dealloc
{

}

- (id)initWithView:(UIView *)animatedView fromView:(UIView *)sendingSuperView toView:(UIView *)receivingSuperView withAnimation:(HBAAnimation *)theAnimation sendingDelegate:(id<HBATransitionSendingDelegate>)sendingDelegate receivingDelegate:(id<HBATransitionReceivingDelegate>)receivingDelegate
{
	if((self = [super init]))
	{
		animated_view = animatedView;
        sending_delegate = sendingDelegate;
        receiving_delegate = receivingDelegate;
        animation = theAnimation;
        sending_superview = sendingSuperView;
        receiving_superview = receivingSuperView;
	}
	
	return self;
}

#pragma -
#pragma Helpful getters

+ (UIWindow *)mainWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

+ (CGRect) windowRectOfView:(UIView*)theView
{
    CGRect originalFrame = theView.frame;
    CGRect newFrame = [[HBAViewTransitionAnimation mainWindow] convertRect:originalFrame fromView:theView.superview];
    
    return  newFrame;
}

- (CGRect) localDestinationRect
{
    CGRect localDestination = [receiving_delegate destinationRectForView:animated_view];
    
    return localDestination;
}

#pragma -
#pragma Notifiers

- (void) notifyRemovedViewFromSender
{
    if([transition_delegate respondsToSelector:@selector(transitionAnimation:didRemoveView:fromViewController:)])
    {
        [transition_delegate transitionAnimation:self didRemoveView:animated_view fromView:sending_superview withSendingViewDelegate:sending_delegate];
    }
    
    if([sending_delegate respondsToSelector:@selector(didSendView:)])
    {
        [sending_delegate didSendView:animated_view];
    }
}

- (void) notifyAddedViewToReceiver
{
    if([transition_delegate respondsToSelector:@selector(transitionAnimation:didAddView:toView:withReceivingViewDelegate:)])
    {
        [transition_delegate transitionAnimation:self didAddView:animated_view toView:receiving_superview withReceivingViewDelegate:receiving_delegate];
    }
    
    if([receiving_delegate respondsToSelector:@selector(didReceiveView:)])
    {
        [receiving_delegate didReceiveView:animated_view];
    }
}

#pragma -
#pragma Transition Mechanics

- (void) removeViewFromSender
{
    CGRect windowRect;
    
    if ([sending_delegate respondsToSelector:@selector(windowRectForView:)])
        windowRect = [sending_delegate windowRectForView:animated_view];
    else 
        windowRect = [HBAViewTransitionAnimation windowRectOfView:animated_view];
    
    [animated_view removeFromSuperview];
    animated_view.frame = windowRect;
    
    [[HBAViewTransitionAnimation mainWindow] addSubview:animated_view];
}

- (void) addViewToReceiver
{
    [animated_view removeFromSuperview];
    
    animated_view.frame = [self localDestinationRect];
    [receiving_superview addSubview:animated_view];
}

- (void) completeTransition
{
    [self addViewToReceiver];
    [self notifyAddedViewToReceiver];
	
	completion_block(animated_view, YES);
}

- (void) performAnimation
{
    animation.completionBlock = ^(UIView * animatedView, BOOL finished){[self completeTransition];};
    [animation fire];
}

#pragma -
#pragma Client facing

- (void) fire
{
	if(![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:@selector(fire) withObject:nil waitUntilDone:YES];
		return;
	}
	
	[self removeViewFromSender];
    [self notifyRemovedViewFromSender];
    
    [self performAnimation];
}

+ (HBAViewTransitionAnimation *)transitionAnimationOfView:(UIView *)animatedView fromView:(UIView *)sendingSuperView toView:(UIView *)receivingSuperView withAnimation:(HBAAnimation *)theAnimation sendingDelegate:(id<HBATransitionSendingDelegate>)sendingDelegate receivingDelegate:(id<HBATransitionReceivingDelegate>)receivingDelegate
{
    HBAViewTransitionAnimation *result = [[HBAViewTransitionAnimation alloc] initWithView:animatedView fromView:sendingSuperView toView:receivingSuperView withAnimation:theAnimation sendingDelegate:sendingDelegate receivingDelegate:receivingDelegate];
    return result;
}

@end
