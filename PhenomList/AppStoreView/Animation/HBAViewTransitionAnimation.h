//
//  HBAViewControllerTransitionAnimation.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 2/7/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HBAAnimation.h"

@class HBAViewTransitionAnimation;

@protocol HBATransitionSendingDelegate<NSObject>

@optional
- (CGRect) windowRectForView:(UIView*)outgoingView;
- (void) didSendView:(UIView*)sentView;

@end


@protocol HBATransitionReceivingDelegate<NSObject>

@required
- (CGRect) destinationRectForView:(UIView*)incomingView;

@optional
- (void) didReceiveView:(UIView*)receivedView;

@end


@protocol HBAViewControllerTransitionAnimationDelegate<NSObject>

@optional
- (void)transitionAnimation:(HBAViewTransitionAnimation *)animation didRemoveView:(UIView *)removedView fromView:(UIView *)sendingSuperView withSendingViewDelegate:(id<HBATransitionSendingDelegate>)sendingViewDelegate;

- (void)transitionAnimation:(HBAViewTransitionAnimation *)animation didAddView:(UIView *)addedView toView:(UIView *)receivingSuperView withReceivingViewDelegate:(id<HBATransitionReceivingDelegate>)receivingViewDelegate;

- (void) transitionAnimation:(HBAViewTransitionAnimation*)theAnimation
      didFinishAnimatingView:(UIView*)animatedView;

@end

@interface HBAViewTransitionAnimation : NSObject {
	__weak id<HBATransitionSendingDelegate> sending_delegate;
	__weak id<HBATransitionReceivingDelegate> receiving_delegate;
	
	HBAAnimation * animation;
    UIView * animated_view;
    UIView * sending_superview;
    UIView * receiving_superview;
	
	__weak id<HBAViewControllerTransitionAnimationDelegate> transition_delegate;
	
	HBAAnimationCompletionBlock completion_block;
}

@property(nonatomic, weak) id<HBAViewControllerTransitionAnimationDelegate> transitionDelegate;
@property(nonatomic, retain) HBAAnimation * animation;
@property(nonatomic, copy) HBAAnimationCompletionBlock completionBlock;

+ (HBAViewTransitionAnimation *)transitionAnimationOfView:(UIView *)animatedView fromView:(UIView *)sendingSuperView toView:(UIView *)receivingSuperView withAnimation:(HBAAnimation *)theAnimation sendingDelegate:(id<HBATransitionSendingDelegate>)sendingDelegate receivingDelegate:(id<HBATransitionReceivingDelegate>)receivingDelegate;
+ (UIWindow *)mainWindow;
+ (CGRect) windowRectOfView:(UIView*)theView;

- (id)initWithView:(UIView *)animatedView fromView:(UIView *)sendingSuperView toView:(UIView *)receivingSuperView withAnimation:(HBAAnimation *)theAnimation sendingDelegate:(id<HBATransitionSendingDelegate>)sendingDelegate receivingDelegate:(id<HBATransitionReceivingDelegate>)receivingDelegate;
- (void) fire;

@end
