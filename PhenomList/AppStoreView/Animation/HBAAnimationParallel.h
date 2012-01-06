//
//  HBAAnimationParallel.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 2/7/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBAAnimation.h"

@interface HBAAnimationParallel : HBAAnimation 
{
	NSMutableSet * animations;
	
	int num_finished;
}

+ (HBAAnimationParallel*) parallel;
+ (HBAAnimationParallel*) parallelWithAnimations:(NSArray*)theAnimations;

- (void) addAnimation:(HBAAnimation*)addedAnimation;
- (void) removeAnimation:(HBAAnimation*)removedAnimation;

@end
