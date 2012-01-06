//
//  HBAAnimation.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 2/7/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAAnimation.h"

#define HBA_ANIMATION_DEFAULT_DURATION 0.3f
#define HBA_ANIMATION_DEFAULT_DELAY 0.0f
#define HBA_ANIMATION_DEFAULT_OPTIONS (UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone)

@implementation HBAAnimation

@synthesize duration, delay, options, context, animationBlock = animation_block, completionBlock = completion_block;

- (void) dealloc
{

}

- (void) initializeDefaults
{
	self.duration = HBA_ANIMATION_DEFAULT_DURATION;
	self.delay = HBA_ANIMATION_DEFAULT_DELAY;
	self.options = HBA_ANIMATION_DEFAULT_OPTIONS;
}

#pragma mark -
#pragma mark Exposed to subclasses

- (void) notifyAnimationFinished:(BOOL)didFinish
{
	if(completion_block)
	{
		completion_block(animated_view, didFinish);
	}
	
	self.animationBlock = nil;
	self.completionBlock = nil;
}

- (void) performAnimation
{
	if(animation_block)
    {
        animation_block(animated_view, context);
    }
}

#pragma mark -
#pragma mark Client facing functions

- (id) init
{
	if((self = [super init]))
	{
		[self initializeDefaults];
	}
	
	return self;
}

- (id) initWithView:(UIView*)animatedView animationBlock:(HBAAnimationBlock)animationBlock
{
	if((self = [self init]))
	{
		animated_view = animatedView;
		self.animationBlock = animationBlock;
	}
	
	return self;
}

- (void) addOption:(UIViewAnimationOptions)newOption
{
	self.options = self.options | newOption;
}


- (void) fire
{
	if(![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:@selector(fire) withObject:nil waitUntilDone:YES];
		return;
	}
	
	if(animation_block)
		[UIView animateWithDuration:self.duration delay:self.delay options:self.options animations:^{[self performAnimation];} completion:^(BOOL finished){[self notifyAnimationFinished:finished];}];
	else
		[self notifyAnimationFinished:YES];
}

#pragma mark -
#pragma mark Factory methods

+ (HBAAnimation*) animationOfView:(UIView*)animatedView withAnimationBlock:(HBAAnimationBlock)animationBlock
{
	return [self animationOfView:animatedView withAnimationBlock:animationBlock completionBlock:nil];
}

+ (HBAAnimation*) animationOfView:(UIView *)animatedView withAnimationBlock:(HBAAnimationBlock)animationBlock completionBlock:(HBAAnimationCompletionBlock)completionBlock
{
	HBAAnimation * result = [[HBAAnimation alloc] initWithView:animatedView animationBlock:animationBlock];
	
	result.completionBlock = completionBlock;
	
	return result;
}

@end
