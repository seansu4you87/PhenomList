//
//  HBAPaginatedViewScrollView.h
//  HBATouch
//
//  Created by Sean Yu on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBAUtility.h"
#import "HBAContentMode.h"
#import "HBAViewTransitionAnimation.h"

@class HBAPaginatedViewScrollView, HBAPaginatedPageView, HBAFullscreenViewController;

@protocol HBAPaginatedViewScrollViewDataSource

- (NSInteger)numberOfPagesInPaginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView;
- (UIView *)paginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView contentViewForIndex:(NSInteger)index;
- (BOOL)isCurrentlyLoading;

@optional

- (HBAPaginatedPageView *)paginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView paginatedPageViewForIndex:(NSInteger)index; //if implemented, overrides margin properties

- (UIView *)loadingViewForPaginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView;
- (UIView *)noResultsViewForPaginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView;

- (NSString *)paginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView captionTitleForIndex:(NSInteger)index;
- (NSString *)paginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView captionSubtitleForIndex:(NSInteger)index;
- (UIView *)paginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView captionViewForIndex:(NSInteger)index;

@end


@protocol HBAPaginatedViewScrollViewDelegate

@optional
- (void)paginatedViewScrollViewDidBeginScrolling:(HBAPaginatedViewScrollView *)paginatedViewScrollView;

@end

@interface HBAPaginatedViewScrollView : UIView<UIScrollViewDelegate, HBATransitionSendingDelegate, HBATransitionReceivingDelegate>
{
    __weak id<HBAPaginatedViewScrollViewDataSource, NSObject> data_source;
    __weak id<HBAPaginatedViewScrollViewDelegate, NSObject> delegate;
    
    UIScrollView *scroll_view;
    
    CGFloat top_margin;
    CGFloat bottom_margin;
    CGFloat left_margin;
    CGFloat right_margin;

    HBADataState data_state;
    
    NSMutableArray *page_views;
    
	HBAContentModeType hba_content_mode_type;
    
    UIPageControl *page_control;
    
    //caption stuff
    BOOL captions_on;
    UITapGestureRecognizer *caption_tap_gesture_recognizer;
    CGFloat default_caption_height;
    __weak UIView *current_caption_view;
    
    //full screen stuff
    BOOL fullscreen_on;
    BOOL is_in_fullscreen;
    UITapGestureRecognizer *fullscreen_tap_gesture_recognizer;
	CGRect old_frame;
	UIView *old_super_view;
	CGSize old_page_size;
	HBAContentModeType old_hba_content_mode_type;
	HBAFullscreenViewController *full_screen_view_controller;
	
	UIView *background_view;
	UIImageView *page_control_background_view;
}

@property(nonatomic, weak) id<HBAPaginatedViewScrollViewDataSource, NSObject> dataSource;
@property(nonatomic, weak) id<HBAPaginatedViewScrollViewDelegate, NSObject> delegate;
@property(nonatomic, assign) CGFloat topMargin, bottomMargin, leftMargin, rightMargin;
@property(nonatomic, assign) HBADataState dataState;
@property(nonatomic, readonly) CGSize pageSize;
@property(nonatomic, assign) HBAContentModeType hbaContentModeType;
@property(nonatomic, retain) UIPageControl *pageControl;
@property(nonatomic, weak) UIView *currentCaptionView;
@property(nonatomic, assign) BOOL captionsOn, fullscreenOn;
@property(readonly, assign) BOOL isInFullscreen;
@property(nonatomic, readonly) CGRect maximumSizedFrameForContentView;
@property(nonatomic, readonly) UITapGestureRecognizer *captionTapGestureRecognizer, *fullscreenTapGestureRecognizer;
@property(nonatomic, retain) UIView *backgroundView;

- (CGFloat)xPositionForIndex:(NSInteger)index;
- (HBAPaginatedPageView *)paginatedPageViewForIndex:(NSInteger)index;
- (UIView *)captionViewAtIndex:(NSInteger)index;
- (void)setCurrentCaptionView;

- (void)setDataState;
- (void)reloadData;
- (void)clearData;
- (void)setViewToLoading;
- (void)setViewToNoResults;

- (void)hideCaptionView;
- (void)showCaptionView;

- (void)enterFullscreen;
- (void)exitFullscreen;

@end
