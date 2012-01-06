//
//  HBAPaginatedInnerFullScreenTransitionManager.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/28/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAPaginatedInnerFullScreenTransitionManager.h"
#import "HBAPaginatedScrollView.h"

#define HBA_PAGINATED_FULLSCREEN_SHADE_DURATION 0.3f
#define HBA_PAGINATED_FULLSCREEN_GROW_DURATION 0.3f

@implementation HBAPaginatedInnerFullScreenTransitionManager

@synthesize previousSuperView = previous_superview;

- (void) dealloc
{

}

- (void) reset
{
    [shade_view removeFromSuperview];

    shade_view = nil;
    self.previousSuperView = nil;
    animated_view = nil;
}

- (void) recordOriginalValuesForView:(HBAPaginatedScrollView*)theAnimatedView
{
    self.previousSuperView = animated_view.superview;
    previous_subview_index = [self.previousSuperView.subviews indexOfObject:animated_view];
    previous_local_frame = animated_view.frame;
    previous_local_transform = animated_view.transform;
    previous_local_bounds = animated_view.bounds;
    previous_center = animated_view.center;
}

- (void) initiateFullScreenEntryOfView:(HBAPaginatedScrollView*)theAnimatedView
{
    if(!theAnimatedView)
        return;
    
    animated_view = theAnimatedView;
    
    [self recordOriginalValuesForView:animated_view];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    UIScreen * mainScreen = [UIScreen mainScreen];
    UIWindow * mainWindow = [UIApplication sharedApplication].keyWindow;
    previous_window_frame = [mainWindow convertRect:animated_view.frame fromView:self.previousSuperView];
    CGRect fullScreenFrame = CGRectMake(0, 0, mainScreen.bounds.size.width, mainScreen.bounds.size.height);

    shade_view = [[UIView alloc] initWithFrame:fullScreenFrame];
    shade_view.backgroundColor = [UIColor blackColor];
    shade_view.alpha = 0.0;
    [mainWindow addSubview:shade_view];
    
    [animated_view removeFromSuperview];
    [mainWindow addSubview:animated_view];

    animated_view.frame = previous_window_frame;
    
    CGPoint centerDiff = CGPointMake(CGRectGetMidX(fullScreenFrame) - CGRectGetMidX(previous_window_frame), 
                                     CGRectGetMidY(fullScreenFrame) - CGRectGetMidY(previous_window_frame));
    
    float xScale = fullScreenFrame.size.width/previous_window_frame.size.width;
    float yScale = fullScreenFrame.size.height/previous_window_frame.size.height;
    
    CGAffineTransform slide = CGAffineTransformMakeTranslation(centerDiff.x, centerDiff.y);
    CGAffineTransform grow = CGAffineTransformMakeScale(xScale, yScale);
    
    CGAffineTransform fullItUp = CGAffineTransformConcat(grow, slide);

    
    
    [UIView animateWithDuration:HBA_PAGINATED_FULLSCREEN_SHADE_DURATION 
                          delay:0
                        options:0
                     animations:^(void){
                         shade_view.alpha = 1.0;
                         
            }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:HBA_PAGINATED_FULLSCREEN_GROW_DURATION animations:^(void){
                         animated_view.transform = fullItUp;
                         } completion:^(BOOL finished) {
                             
                         }];
                         
                     }];
}

- (void) initiateFullScreenExit
{
    if(!animated_view)
        return;
    
    [UIView animateWithDuration:HBA_PAGINATED_FULLSCREEN_SHADE_DURATION
                     animations:^(void){
                         animated_view.transform = previous_local_transform;
                     } 
                     completion:^(BOOL finished){
                         [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                         [UIView animateWithDuration:HBA_PAGINATED_FULLSCREEN_SHADE_DURATION animations:^(void){
                             shade_view.alpha = 0.0f;
                         } completion:^(BOOL finished){
                             [animated_view removeFromSuperview];
                             
                             [previous_superview insertSubview:animated_view atIndex:previous_subview_index];
                             
                             animated_view.bounds = previous_local_bounds;
                             animated_view.transform = previous_local_transform;
                             animated_view.center = previous_center;
                             animated_view.frame = previous_local_frame;
                             animated_view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                             
                             
                             
                             
                             [self reset];}];
                         
                     }];
}

@end
