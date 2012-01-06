//
//  HBAAnimationSequence.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 2/7/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAAnimationSequence.h"


@implementation HBAAnimationSequence

- (void) dealloc
{

}

- (id) initWithAnimations:(NSArray*)theAnimations
{
	self = [super init]; 
    
    if(self)
	{
		animations = [NSMutableArray arrayWithArray:theAnimations];
	}
	
	return self;
}

+ (HBAAnimationSequence*) sequence
{
	return [self sequenceWithAnimations:[NSArray array]];
}

+ (HBAAnimationSequence*) sequenceWithAnimations:(NSArray*)theAnimations
{
	HBAAnimationSequence * sequence = [[HBAAnimationSequence alloc] initWithAnimations:theAnimations];
	
	return sequence;
}

- (void) addAnimation:(HBAAnimation*)animation
{
	[animations addObject:animation];
}

- (void) removeAnimation:(HBAAnimation*)animation
{
	[animations removeObject:animation];
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
	
	current_index = 0;
	
	HBAAnimationCompletionBlock doneBlock = ^(UIView * theView, BOOL finished){
		current_index++;
		
		if(current_index == [animations count])
		{
			[self notifyAnimationFinished:YES];
		}else{
			HBAAnimation * nextAnimation = [animations objectAtIndex:current_index];
			[nextAnimation fire];
		}
	};
	
	for(HBAAnimation * animation in animations)
	{
        HBAAnimationCompletionBlock originalBlock = [animation.completionBlock copy];
        HBAAnimationCompletionBlock modifiedDoneBlock = ^(UIView * theView, BOOL finished){
            if(originalBlock)
            {
                originalBlock(theView, finished);
            }
            doneBlock(theView, finished);
        };
        
		animation.completionBlock = modifiedDoneBlock;
	}
	
	HBAAnimation * firstAnimation = [animations objectAtIndex:0];
	[firstAnimation fire];
}

@end
