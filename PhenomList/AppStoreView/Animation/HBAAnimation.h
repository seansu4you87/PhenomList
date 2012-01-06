//
//  HBAAnimation.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 2/7/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HBAAnimationBlock)(UIView * animatedView, id context);
typedef void (^HBAAnimationCompletionBlock)(UIView * animatedView, BOOL finished);

@interface HBAAnimation : NSObject {
	UIView * animated_view;
	
	float duration;
	float delay;
	UIViewAnimationOptions options;
    
    id context;
	
	HBAAnimationBlock animation_block;
	HBAAnimationCompletionBlock completion_block;
}

@property(nonatomic, copy) HBAAnimationBlock animationBlock;
@property(nonatomic, copy) HBAAnimationCompletionBlock completionBlock;
@property(nonatomic, assign) float duration, delay;
@property(nonatomic, assign) UIViewAnimationOptions options;
@property(nonatomic, retain) id context;


+ (HBAAnimation*) animationOfView:(UIView*)animatedView withAnimationBlock:(HBAAnimationBlock)animationBlock;
+ (HBAAnimation*) animationOfView:(UIView *)animatedView withAnimationBlock:(HBAAnimationBlock)animationBlock completionBlock:(HBAAnimationCompletionBlock)completionBlock;

- (void) fire;
- (void) addOption:(UIViewAnimationOptions)newOption;

#pragma mark -
#pragma mark For Subclasses to override

- (void) performAnimation;
- (void) notifyAnimationFinished:(BOOL)didFinish;

@end
