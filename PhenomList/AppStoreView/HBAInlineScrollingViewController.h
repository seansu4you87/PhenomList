//
//  HBAInlineScrollingViewController.h
//  HBATouch
//
//  Created by Sean Yu on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HBAPaginatedViewScrollView.h"

typedef enum {
	HBAInlineScrollingViewControllerStateTop,
	HBAInlineScrollingViewControllerStatePageControl,
	HBAInlineScrollingViewControllerStateBottom,
	HBAInlineScrollingViewControllerStateInBetween
}HBAInlineScrollingViewControllerState;

@interface HBAInlineScrollingViewController : UIViewController<UIScrollViewDelegate, HBAPaginatedViewScrollViewDelegate>
{
	UIScrollView *scroll_view;
	UIView *header_view;
	UIView *footer_view;
	
	HBAPaginatedViewScrollView *paginated_image_scroll_view;
	CGFloat paginated_image_scroll_view_height;
	
	int num_failed_scroll_attempts;
	BOOL is_dragging;
	HBAInlineScrollingViewControllerState state;
}

@property(nonatomic, retain) UIView *headerView, *footerView;
@property(nonatomic, retain, readonly) HBAPaginatedViewScrollView *paginatedViewScrollView;
@property(assign, readonly) CGFloat topPaginatedImageScrollViewThreshold, bottomPaginatedImageScrollViewThreshold;
@property(nonatomic, assign) HBAInlineScrollingViewControllerState state;

- (void) reloadData;

- (void)setUpHeaderView;
- (void)setUpFooterView;
- (void)reframeViews;
- (void)snapToPaginatedImageScrollViewAnimated:(BOOL)animated;
- (void)snapAbovePaginatedImageScrollViewAnimated:(BOOL)animated;
- (void)snapBelowPaginatedImageScrollViewAnimated:(BOOL)animated;

- (void) setState:(HBAInlineScrollingViewControllerState)newState animated:(BOOL)shouldAnimate;

@end
