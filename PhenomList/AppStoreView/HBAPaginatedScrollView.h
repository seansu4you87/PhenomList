//
//  HBAPaginatedScrollView.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/27/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBAPaginatedScrollView, HBAPaginatedInnerScrollView, HBAPaginatedInnerFullScreenTransitionManager;

@protocol HBAPaginatedScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfPagesInPaginatedScrollView:(HBAPaginatedScrollView *)paginatedScrollView;

- (UIView *)paginatedScrollView:(HBAPaginatedScrollView *)paginatedScrollView 
            contentViewForIndex:(NSInteger)index;

@optional
- (UIEdgeInsets) paginatedScrollView:(HBAPaginatedScrollView*)paginatedScrollView 
               marginsForViewAtIndex:(NSInteger)index;

- (UIViewContentMode) paginatedScrollView:(HBAPaginatedScrollView*)paginatedScrollView 
                contentModeForViewAtIndex:(NSInteger)index;

@end

@protocol HBAPaginatedScrollViewDelegate <NSObject>

- (void) paginatedScrollViewWillGoFullScreen:(HBAPaginatedScrollView*)scrollView;
- (void) paginatedScrollViewDidGoFullScreen:(HBAPaginatedScrollView*)scrollView;
- (void) paginatedScrollViewWillExitFullScreen:(HBAPaginatedScrollView*)scrollView;
- (void) paginatedScrollViewDidExitFullScreen:(HBAPaginatedScrollView*)scrollView;

@end

@interface HBAPaginatedScrollView : UIView {
    __weak id<HBAPaginatedScrollViewDelegate> delegate;
    HBAPaginatedInnerScrollView * scroll_view;
    
    UITapGestureRecognizer *single_tap_recognizer;
    UITapGestureRecognizer *double_tap_recognizer;
    BOOL is_fullscreen;
    HBAPaginatedInnerFullScreenTransitionManager * transition_manager;
}

@property(nonatomic, assign) id<HBAPaginatedScrollViewDataSource> dataSource;
@property(nonatomic, weak) id<HBAPaginatedScrollViewDelegate> delegate;
@property(nonatomic, readonly) UITapGestureRecognizer *doubleTapRecognizer, *singleTapRecognizer;
@property(nonatomic, readonly) BOOL isFullScreen;
@property(nonatomic, assign) BOOL isActive;

- (void) reloadData;
- (void) reloadDataAtIndices:(NSArray*)pageNumbers;//this needs to be an array of NSNumbers (made w/ integers)
- (void) reloadDataAtIndex:(int)pageIndex;
- (UIView*) contentViewAtIndex:(int)pageIndex;

- (void) snapContentOffsetAnimated:(BOOL)shouldAnimate;
- (void) snapContentOffsetAnimated:(BOOL)shouldAnimate forNewFrame:(CGRect)newFrame;

@end
