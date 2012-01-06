//
//  HBAAnimationParallel.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 2/7/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAAnimationParallel.h"


@implementation HBAAnimationParallel

- (void) dealloc
{

}

- (id) init
{
	if((self = [super init]))
	{
		animations = [NSMutableSet setWithCapacity:0];
	}
	
	return self;
}

- (id) initWithAnimations:(NSArray*)allAnimations
{
	if((self = [self init]))
	{
		[animations addObjectsFromArray:allAnimations];
	}
	
	return self;
}

- (void) addAnimation:(HBAAnimation*)addedAnimation
{
	[animations addObject:addedAnimation];
}

- (void) removeAnimation:(HBAAnimation*)removedAnimation
{
	[animations removeObject:removedAnimation];
}

- (void) fire
{
	if(![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:@selector(fire) withObject:nil waitUntilDone:YES];
		return;
	}
	
	if([animations count] == 0)
	{
		[self notifyAnimationFinished:YES];
		return;
	}
	
	num_finished = 0;
	
	HBAAnimationCompletionBlock doneBlock = ^(UIView * animatedView, BOOL finished){
		num_finished++;
		
		if(num_finished == [animations count])
		{
			[self notifyAnimationFinished:YES];
		}
	};
	
	for(HBAAnimation * animation in animations)
	{
		animation.completionBlock = doneBlock;
		[animation fire];
	}
}

#pragma mark -
#pragma mark Factory Methods

+ (HBAAnimationParallel*) parallel
{
	return [HBAAnimationParallel parallelWithAnimations:[NSArray array]];
}

+ (HBAAnimationParallel*) parallelWithAnimations:(NSArray*)theAnimations
{
	HBAAnimationParallel * result = [[HBAAnimationParallel alloc] initWithAnimations:theAnimations];
	
	return result;
}

@end
