//
//  HBAAnimationSequence.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 2/7/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBAAnimation.h"

@interface HBAAnimationSequence : HBAAnimation {
	NSMutableArray * animations;
	
	int current_index;
}

+ (HBAAnimationSequence*) sequence;
+ (HBAAnimationSequence*) sequenceWithAnimations:(NSArray*)theAnimations;

- (void) addAnimation:(HBAAnimation*)animation;
- (void) removeAnimation:(HBAAnimation*)animation;

@end
