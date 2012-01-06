    //
//  HBAInlineScrollingViewController.m
//  HBATouch
//
//  Created by Sean Yu on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HBAInlineScrollingViewController.h"

@implementation HBAInlineScrollingViewController

@synthesize headerView = header_view, footerView = footer_view, paginatedViewScrollView = paginated_image_scroll_view;
@synthesize state, topPaginatedImageScrollViewThreshold, bottomPaginatedImageScrollViewThreshold;

- (void)dealloc 
{

}

- (id)init
{
	if (self = [super initWithNibName:nil bundle:nil])
	{
		paginated_image_scroll_view_height = 480 - 44 - 20 - 44;
		state = HBAInlineScrollingViewControllerStateTop;
	}
	return self;
}

- (void)setUpHeaderView
{
	
}

- (void)setUpFooterView
{
	
}

- (void)loadView
{
	[super loadView];
	
	if(!self.headerView)
		[self setUpHeaderView];
	
	if(!self.footerView)
		[self setUpFooterView];
	
	if(!paginated_image_scroll_view)
	{
		paginated_image_scroll_view = [[HBAPaginatedViewScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, paginated_image_scroll_view_height)];
        paginated_image_scroll_view.leftMargin = 30;
        paginated_image_scroll_view.rightMargin = 30;
        paginated_image_scroll_view.topMargin = 10;
        paginated_image_scroll_view.bottomMargin = 30;
        paginated_image_scroll_view.hbaContentModeType = HBAContentModeTypeScaleAspectFit;
		paginated_image_scroll_view.delegate = self;
	}
	
	if(!scroll_view)
	{
		scroll_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		scroll_view.delegate = self;
		
		[scroll_view addSubview:self.headerView];
		[scroll_view addSubview:self.paginatedViewScrollView];
		[scroll_view addSubview:self.footerView];
	}
	
	
	self.view = scroll_view;
	
	[self reframeViews];
	
	self.state = state;
}

- (void) viewDidUnload
{
	[super viewDidUnload];
	
	paginated_image_scroll_view = nil;
	
	scroll_view = nil;
	
	self.headerView = nil;
	self.footerView = nil;
}

- (void)reframeViews
{	
	HBAMoveView(self.headerView, (self.view.frame.size.width - self.headerView.frame.size.width) / 2, 0);
	HBAMoveView(self.paginatedViewScrollView, (self.view.frame.size.width - self.headerView.frame.size.width) / 2, CGRectGetMaxY(self.headerView.frame));
	HBAMoveView(self.footerView, (self.view.frame.size.width - self.headerView.frame.size.width) / 2, CGRectGetMaxY(self.paginatedViewScrollView.frame));
	
	scroll_view.contentSize = CGSizeMake(scroll_view.frame.size.width, self.headerView.frame.size.height + self.paginatedViewScrollView.frame.size.height + self.footerView.frame.size.height);
}

#define HBA_INLINE_SCROLLING_VIEW_CONTROLLER_GRAVITY_RANGE 5
#define HBA_INLINE_SCROLLING_VIEW_CONTROLLER_MAX_NUM_FAILED_SCROLL_ATTEMPTS 15

- (CGFloat)topPaginatedImageScrollViewThreshold
{
	return self.paginatedViewScrollView.frame.origin.y - HBA_INLINE_SCROLLING_VIEW_CONTROLLER_GRAVITY_RANGE;
}

- (CGFloat)bottomPaginatedImageScrollViewThreshold
{
	return CGRectGetMaxY(self.paginatedViewScrollView.frame) + HBA_INLINE_SCROLLING_VIEW_CONTROLLER_GRAVITY_RANGE;
}

- (void)snapToPaginatedImageScrollViewAnimated:(BOOL)animated
{
	[scroll_view setContentOffset:self.paginatedViewScrollView.frame.origin animated:animated];
	state = HBAInlineScrollingViewControllerStatePageControl;
	num_failed_scroll_attempts++;
}

- (void) scrolledAwayFromPaginatedView
{
	[self.paginatedViewScrollView hideCaptionView];
}

- (void)snapAbovePaginatedImageScrollViewAnimated:(BOOL)animated
{
	[scroll_view setContentOffset:CGPointMake(self.paginatedViewScrollView.frame.origin.x, self.topPaginatedImageScrollViewThreshold)];
	num_failed_scroll_attempts = 0;
	
	[self scrolledAwayFromPaginatedView];
}

- (void)snapBelowPaginatedImageScrollViewAnimated:(BOOL)animated
{
	[scroll_view setContentOffset:CGPointMake(self.paginatedViewScrollView.frame.origin.x, self.bottomPaginatedImageScrollViewThreshold - scroll_view.frame.size.height)];
	num_failed_scroll_attempts = 0;
	
	[self scrolledAwayFromPaginatedView];
}

- (void) reloadData
{
	if(![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
		return;
	}
	
	[self.paginatedViewScrollView reloadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	//NSLog(@"begin dragging");
	if (scrollView.decelerating)
		is_dragging = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	//NSLog(@"scroll view did end dragging");
	num_failed_scroll_attempts = 0;
	is_dragging = NO;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	//NSLog(@"being decelerate");
}

- (float) yOffsetForState:(HBAInlineScrollingViewControllerState)theState
{
	switch (theState) {
		case HBAInlineScrollingViewControllerStateTop:
			return 0;
		case HBAInlineScrollingViewControllerStatePageControl:
			return paginated_image_scroll_view.frame.origin.y;
		case HBAInlineScrollingViewControllerStateBottom:
			return scroll_view.contentSize.height - scroll_view.frame.size.height;
		case HBAInlineScrollingViewControllerStateInBetween:
			return -1;
	}
	
	return -1;
}

- (BOOL) offset:(float)a isCloseTo:(float)b
{
	return fabs(a - b) <= 1;
}

- (void) setStateFromCurrentPosition
{
	float currentYOffset = scroll_view.contentOffset.y;
	
	if([self offset:currentYOffset isCloseTo:[self yOffsetForState:HBAInlineScrollingViewControllerStateTop]])
	{
		state = HBAInlineScrollingViewControllerStateTop;
	}else if([self offset:currentYOffset isCloseTo:[self yOffsetForState:HBAInlineScrollingViewControllerStateBottom]])
	{
		state = HBAInlineScrollingViewControllerStateBottom;
	}else if([self offset:currentYOffset isCloseTo:[self yOffsetForState:HBAInlineScrollingViewControllerStatePageControl]])
	{
		state = HBAInlineScrollingViewControllerStatePageControl;
	}else
	{
		state = HBAInlineScrollingViewControllerStateInBetween;
	}
}

- (void) setState:(HBAInlineScrollingViewControllerState)newState
{
	[self setState:newState animated:NO];
}

- (void) setState:(HBAInlineScrollingViewControllerState)newState animated:(BOOL)shouldAnimate
{
	state = newState;
	
	if(state != HBAInlineScrollingViewControllerStateInBetween)
	{
		CGPoint newContentOffset = CGPointMake(scroll_view.contentOffset.x, [self yOffsetForState:state]);
		[scroll_view setContentOffset:newContentOffset animated:shouldAnimate];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	//NSLog(@"end decelerate");
	[self setStateFromCurrentPosition];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
	if (scrollView.dragging && (!scrollView.decelerating || is_dragging) )
	{
		if (scrollView.contentOffset.y > self.topPaginatedImageScrollViewThreshold && scrollView.contentOffset.y < self.paginatedViewScrollView.frame.origin.y)
		{
			if (num_failed_scroll_attempts <= HBA_INLINE_SCROLLING_VIEW_CONTROLLER_MAX_NUM_FAILED_SCROLL_ATTEMPTS)
				[self snapToPaginatedImageScrollViewAnimated:NO];
			else 
				[self snapAbovePaginatedImageScrollViewAnimated:NO];
		}
		else if ( (scrollView.contentOffset.y + scrollView.frame.size.height) < self.bottomPaginatedImageScrollViewThreshold && (scrollView.contentOffset.y + scrollView.frame.size.height) > CGRectGetMaxY(self.paginatedViewScrollView.frame) )
		{
			if (num_failed_scroll_attempts <= HBA_INLINE_SCROLLING_VIEW_CONTROLLER_MAX_NUM_FAILED_SCROLL_ATTEMPTS)
				[self snapToPaginatedImageScrollViewAnimated:NO];
			else 
				[self snapBelowPaginatedImageScrollViewAnimated:NO];
		}
	}
	
	/*if (scrollView.dragging)
		NSLog(@"scroll view draggin");
	if (scrollView.decelerating)
		NSLog(@"scroll view decelerating");
	NSLog(@"%i", num_failed_scroll_attempts);*/
}

#pragma mark -
#pragma mark HBAPaginatedViewScrollViewDelegate methods

- (void)paginatedViewScrollViewDidBeginScrolling:(HBAPaginatedViewScrollView *)thePaginatedImageScrollView
{
	[self snapToPaginatedImageScrollViewAnimated:YES];
}

@end
