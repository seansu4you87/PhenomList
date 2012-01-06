//
//  HBAPaginatedScrollView.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/27/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAPaginatedScrollView.h"
#import "HBAPaginatedInnerScrollView.h"
#import "HBAPaginatedInnerFullScreenTransitionManager.h"

@interface HBAPaginatedScrollView (Private)

- (CGRect) scrollViewFrame;

@end


@implementation HBAPaginatedScrollView

@synthesize delegate, dataSource, doubleTapRecognizer = double_tap_recognizer;
@synthesize isFullScreen = is_fullscreen, singleTapRecognizer = single_tap_recognizer;
@synthesize isActive;

- (void)dealloc
{
    delegate = nil;
    scroll_view.dataSource = nil;
    scroll_view.parentScrollView = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = YES;
        
        scroll_view = [[HBAPaginatedInnerScrollView alloc] initWithFrame:[self scrollViewFrame]];
        scroll_view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        scroll_view.parentScrollView = self;
        [self addSubview:scroll_view];
        
        single_tap_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped)];
        single_tap_recognizer.numberOfTapsRequired = 1;
        
        double_tap_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped)];
        double_tap_recognizer.numberOfTapsRequired = 2;
        [scroll_view addGestureRecognizer:double_tap_recognizer];
        
        transition_manager = [[HBAPaginatedInnerFullScreenTransitionManager alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark Delegate interaction

- (void) notifyDelegateWillGoFullScreen
{
    if([self.delegate respondsToSelector:@selector(paginatedScrollViewWillGoFullScreen:)])
    {
        [self.delegate paginatedScrollViewWillGoFullScreen:self];
    }
}

- (void) notifyDelegateWillExitFullScreen
{
    if([self.delegate respondsToSelector:@selector(paginatedScrollViewWillExitFullScreen:)])
    {
        [self.delegate paginatedScrollViewWillExitFullScreen:self];
    }
}

#pragma mark -
#pragma mark Fullscreen

- (void) enterFullScreen
{
    [self notifyDelegateWillGoFullScreen];
    
    [self removeGestureRecognizer:double_tap_recognizer];
    [self addGestureRecognizer:single_tap_recognizer];
    
    [transition_manager initiateFullScreenEntryOfView:self];
    
    is_fullscreen = YES;
}

- (void) exitFullScreen
{
    [self notifyDelegateWillExitFullScreen];
    
    [self removeGestureRecognizer:single_tap_recognizer];
    [self addGestureRecognizer:double_tap_recognizer];
    
    [transition_manager initiateFullScreenExit];
    
    is_fullscreen = NO;
}

- (void) doubleTapped
{
    //NSLog(@"new scroll view double tapped");
    if(!is_fullscreen)
    {
        [self enterFullScreen];
    }
}

- (void) singleTapped
{
    if(is_fullscreen)
    {
        [self exitFullScreen];
    }
}

#pragma mark -
#pragma mark View management



- (void) reloadData
{
    [scroll_view reloadData];
}

- (void) reloadDataAtIndices:(NSArray*)pageNumbers
{
    [scroll_view reloadDataAtIndices:pageNumbers];
}

- (void) reloadDataAtIndex:(int)pageIndex
{
    [scroll_view reloadDataAtIndex:pageIndex];
}

- (UIView*) contentViewAtIndex:(int)pageIndex
{
    return [scroll_view contentViewAtIndex:pageIndex];
}

- (void) snapContentOffsetAnimated:(BOOL)shouldAnimate
{
    [scroll_view snapContentOffsetAnimated:(BOOL)shouldAnimate];
}

- (void) snapContentOffsetAnimated:(BOOL)shouldAnimate forNewFrame:(CGRect)newFrame
{
    [scroll_view snapContentOffsetAnimated:shouldAnimate forNewFrame:newFrame];
}

#pragma mark -
#pragma mark Layout

- (CGRect) scrollViewFrame
{
    CGRect result = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    return result;
}


#pragma mark -
#pragma mark Property overrides

- (void) setDataSource:(id<HBAPaginatedScrollViewDataSource>)newDataSource
{
    scroll_view.dataSource = newDataSource;
}

- (id<HBAPaginatedScrollViewDataSource>) dataSource
{
    return scroll_view.dataSource;
}

- (void) setFrame:(CGRect)newFrame
{
    if(newFrame.size.height == 0)//i don't understand this bug.
        newFrame = CGRectMake(newFrame.origin.x, newFrame.origin.y, newFrame.size.width, 0.000001);
    
    //NSLog(@"new frame x:%f y:%f w:%f h:%f", newFrame.origin.x, newFrame.origin.y, newFrame.size.width, newFrame.size.height);
    //NSLog(@"current frame is %@", self.description);
    
    [super setFrame:newFrame];

    //NSLog(@"after frame of %@ when superview is %@", self.description, self.superview.description);
}

- (BOOL) isActive
{
    return scroll_view.isActive;
}

- (void) setIsActive:(BOOL)active
{
    scroll_view.isActive = active;
}

@end
