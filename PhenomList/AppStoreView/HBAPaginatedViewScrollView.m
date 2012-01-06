//
//  HBAPaginatedViewScrollView.m
//  HBATouch
//
//  Created by Sean Yu on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HBAPaginatedViewScrollView.h"
#import "HBAPaginatedPageView.h"
#import "HBACaptionView.h"
#import "HBANotificationCenter.h"

#import "HBAFullscreenViewController.h"
#import "HBAViewTransitionAnimation.h"
#import "HBAAnimation.h"
#import "HBAAnimationSequence.h"
#import "HBAAnimationParallel.h"

#define HBA_PAGINATED_VIEW_FULLSCREEN_TRANSITION_DARKEN_DURATION 0.2f
#define HBA_PAGINATED_VIEW_FULLSCREEN_TRANSITION_GROW_DURATION 0.3f

@implementation HBAPaginatedViewScrollView

@synthesize dataSource = data_source, delegate = delegate;
@synthesize topMargin = top_margin, bottomMargin = bottom_margin, leftMargin = left_margin, rightMargin = right_margin;
@synthesize dataState = data_state, pageSize, hbaContentModeType = hba_content_mode_type, currentCaptionView = current_caption_view;
@synthesize pageControl = page_control, captionsOn = captions_on, maximumSizedFrameForContentView, fullscreenOn = fullscreen_on;
@synthesize captionTapGestureRecognizer = caption_tap_gesture_recognizer;
@synthesize fullscreenTapGestureRecognizer = fullscreen_tap_gesture_recognizer, isInFullscreen = is_in_fullscreen;
@synthesize backgroundView = background_view;

- (void)dealloc
{

}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.clipsToBounds = YES;
        
        scroll_view = [[UIScrollView alloc] initWithFrame:self.frame];
        scroll_view.showsVerticalScrollIndicator = NO;
        scroll_view.showsHorizontalScrollIndicator = NO;
        scroll_view.directionalLockEnabled = YES;
        scroll_view.pagingEnabled = YES;
        scroll_view.clipsToBounds = NO;
        scroll_view.delegate = self;
        scroll_view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:scroll_view];
        
        page_views = [[NSMutableArray alloc] init];
        
		page_control_background_view = [[UIImageView alloc] initWithFrame:CGRectZero];
		page_control_background_view.image = [[UIImage imageNamed:@"HBAPageControlBackground.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:5];
		[self addSubview:page_control_background_view];
		
        page_control = [[UIPageControl alloc] initWithFrame:CGRectZero];
        [page_control addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
        [self addSubview:page_control];
        
        caption_tap_gesture_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped)];
        self.captionsOn = YES;
        
        fullscreen_tap_gesture_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped)];
        fullscreen_tap_gesture_recognizer.numberOfTapsRequired = 2;
        [caption_tap_gesture_recognizer requireGestureRecognizerToFail:fullscreen_tap_gesture_recognizer];
        self.fullscreenOn = YES;
        
        self.hbaContentModeType = -1;
    }
    return  self;
}

- (void) resizePageViews
{
    for(int i = 0; i < [page_views count]; i++)
    {
        HBAPaginatedPageView * pageView = [page_views objectAtIndex:i];
        HBAMoveView(pageView, [self xPositionForIndex:i], 0);
    }
}

- (void) resizeScrollView
{
    scroll_view.contentSize = CGSizeMake([page_views count] * (self.pageSize.width), scroll_view.frame.size.height);
}

- (CGFloat)xPositionForIndex:(NSInteger)index
{
	return index * (self.pageSize.width);
}

- (void) resizeSubviews
{
    [self resizePageViews];
    [self resizeScrollView];
}


#define HBA_PAGINATED_VIEW_SCROLL_VIEW_PAGE_CONTROL_HEIGHT 20
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect scrollViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (!CGRectEqualToRect(scrollViewFrame, scroll_view.frame))
        scroll_view.frame = scrollViewFrame;
    
    CGRect pageControlFrame = CGRectMake(0, self.frame.size.height - HBA_PAGINATED_VIEW_SCROLL_VIEW_PAGE_CONTROL_HEIGHT - 3, self.frame.size.width, HBA_PAGINATED_VIEW_SCROLL_VIEW_PAGE_CONTROL_HEIGHT);
    if (!CGRectEqualToRect(pageControlFrame, page_control.frame) )
		page_control.frame = pageControlFrame;
    
	CGSize necessaryPageControlSize = CGSizeMake([page_control sizeForNumberOfPages:page_control.numberOfPages].width + 8, 12);
	CGRect pageControlBackgroundFrame = CGRectMake( (self.frame.size.width - necessaryPageControlSize.width) / 2.0, pageControlFrame.origin.y + 4, necessaryPageControlSize.width, necessaryPageControlSize.height);
	
	if (!CGRectEqualToRect(pageControlBackgroundFrame, page_control_background_view.frame))
		page_control_background_view.frame = pageControlBackgroundFrame;
	
    [self resizeSubviews];
}




- (void)setDataState
{
    if ([self.dataSource isCurrentlyLoading])
		self.dataState = HBADataStateLoading;
	else if ([self.dataSource numberOfPagesInPaginatedViewScrollView:self] == 0)
		self.dataState = HBADataStateNoResults;
	else if ([self.dataSource numberOfPagesInPaginatedViewScrollView:self] > 0)
		self.dataState = HBADataStateHasData;
}

- (void)reloadData
{
    [self clearData];
    
    for (int index = 0; index < [self.dataSource numberOfPagesInPaginatedViewScrollView:self]; index++)
    {
        HBAPaginatedPageView *pageView = [self paginatedPageViewForIndex:index];
        
        [scroll_view addSubview:pageView];
        [page_views addObject:pageView];
    }
     
    [self resizeScrollView];
    
    page_control.numberOfPages = [page_views count];
    [self setCurrentCaptionView];
}

- (HBAPaginatedPageView *)paginatedPageViewForIndex:(NSInteger)index
{
    HBAPaginatedPageView *pageView;
    if ([self.dataSource respondsToSelector:@selector(paginatedViewScrollView:paginatedPageViewForIndex:)])
        pageView = [self.dataSource paginatedViewScrollView:self paginatedPageViewForIndex:index];
    else 
    {
        pageView = [[HBAPaginatedPageView alloc] initWithFrame:CGRectMake(0, 0, self.pageSize.width, self.pageSize.height)];
        pageView.topMargin = self.topMargin;
        pageView.bottomMargin = self.bottomMargin;
        pageView.leftMargin = self.leftMargin;
        pageView.rightMargin = self.rightMargin;
        
		//HBALogRect(pageView.frame);
		
        if (self.hbaContentModeType != -1)
            pageView.hbaContentModeType = self.hbaContentModeType;
        else 
            pageView.hbaContentModeType = HBAContentModeTypeScaleAspectFill;
    }
    pageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    pageView.contentView = [self.dataSource paginatedViewScrollView:self contentViewForIndex:index];
   
    
    HBAMoveView(pageView, [self xPositionForIndex:index], 0);
    
    return pageView;
}

- (void)clearData
{
    for (UIView *view in page_views)
    {
        [view removeFromSuperview];
    }
    
    [page_views removeAllObjects];
}

- (void)setViewToLoading
{
    
}

- (void)setViewToNoResults
{
    
}

- (void)pageChanged
{
    [scroll_view setContentOffset:CGPointMake([self xPositionForIndex:page_control.currentPage], 0) animated:YES];
}

#pragma mark -
#pragma mark Caption methods

+ (HBACaptionView *)defaultCaptionView
{
    HBACaptionView *captionView = [[HBACaptionView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    return captionView;
}

- (UIView *)captionViewAtIndex:(NSInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(paginatedViewScrollView:captionViewForIndex:)])
	{
		return [self.dataSource paginatedViewScrollView:self captionViewForIndex:index];
	}
	
	HBACaptionView *captionView = [HBAPaginatedViewScrollView defaultCaptionView];
	HBASizeChangeView(captionView, self.frame.size.width, 50);
	
	BOOL hasText = NO;
	if ([self.dataSource respondsToSelector:@selector(paginatedViewScrollView:captionTitleForIndex:)])
	{
		NSString *titleString = [self.dataSource paginatedViewScrollView:self captionTitleForIndex:index];
		if ([titleString length])
		{
			hasText = YES;
			captionView.titleLabel.text = titleString;
		}
	}
	
	if ([self.dataSource respondsToSelector:@selector(paginatedViewScrollView:captionSubtitleForIndex:)])
	{
		NSString *subtitleString = [self.dataSource paginatedViewScrollView:self captionSubtitleForIndex:index];
		if ([subtitleString length])
		{
			hasText = YES;
			captionView.subtitleLabel.text = subtitleString;
		}
	}
	
	[captionView reframeLabels];
	
	if (hasText)
		return captionView;
	else 
		return nil;
}

- (void)showCaptionView
{
	if (current_caption_view)
	{
		[UIView beginAnimations:@"show caption view" context:nil];
		
		if ([self.dataSource respondsToSelector:@selector(paginatedViewScrollView:captionViewForIndex:)])
			current_caption_view.alpha = 1;
		else 
			current_caption_view.alpha = 1;
		
		[UIView commitAnimations];
	}
}

- (void)hideCaptionView
{
	if (current_caption_view)
	{
		[UIView beginAnimations:@"hide caption view" context:nil];
		
		current_caption_view.alpha = 0;
		
		[UIView commitAnimations];
	}
}

- (void)singleTapped
{	
	if (caption_tap_gesture_recognizer.numberOfTouches == 1)
	{
		HBALog(@"caption view shown");
		if (current_caption_view.alpha == 0)
			[self showCaptionView];
		else 
			[self hideCaptionView];
	}
}

- (void)setCurrentCaptionView
{
	[current_caption_view removeFromSuperview];
	current_caption_view = [self captionViewAtIndex:page_control.currentPage];
	current_caption_view.alpha = 0;
	[self addSubview:current_caption_view];
}

#pragma mark -
#pragma mark Fullscreen methods

- (void)doubleTapped
{    
    if (!self.isInFullscreen)
    {
        [self enterFullscreen];
    }
    else 
    {    
        [self exitFullscreen];
    }
}

- (void)enterFullscreen
{
	HBALog(@"entering fullscreen");
    if([page_views count] == 0)
        return;
	
	page_control_background_view.hidden = YES;
	background_view.hidden = YES;
	
	old_frame = self.frame;
	old_super_view = self.superview;
	old_page_size = self.pageSize;
	old_hba_content_mode_type = self.hbaContentModeType;
	
	full_screen_view_controller = [[HBAFullscreenViewController alloc] init];
	[full_screen_view_controller loadView];
    
    full_screen_view_controller.view.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:full_screen_view_controller.view];
    
    HBAAnimation *darkenAnimation = [HBAAnimation animationOfView:full_screen_view_controller.view withAnimationBlock:^(UIView *animatedView, id context){
        
        full_screen_view_controller.view.alpha = 1;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    }];
    darkenAnimation.duration = HBA_PAGINATED_VIEW_FULLSCREEN_TRANSITION_DARKEN_DURATION;
    
    
    HBAPaginatedPageView *currentPage = [page_views objectAtIndex:page_control.currentPage];
    currentPage.hbaContentModeType = HBAContentModeTypeScaleAspectFit;
	
    HBAAnimation *growAnimation = [currentPage sizeChangeAnimationForNewFrame:[UIApplication sharedApplication].keyWindow.frame];
    growAnimation.duration = HBA_PAGINATED_VIEW_FULLSCREEN_TRANSITION_GROW_DURATION;
    
    HBAAnimationSequence *sequence = [HBAAnimationSequence sequenceWithAnimations:[NSArray arrayWithObjects:darkenAnimation, growAnimation, nil]];
	
    HBAViewTransitionAnimation *transitionAnimation = [HBAViewTransitionAnimation transitionAnimationOfView:currentPage 
                                                                                                   fromView:scroll_view 
                                                                                                     toView:full_screen_view_controller.view 
                                                                                              withAnimation:sequence 
                                                                                            sendingDelegate:self 
                                                                                          receivingDelegate:self];
	
	transitionAnimation.completionBlock = ^(UIView *animatedView, BOOL finished){
		
		self.hbaContentModeType = HBAContentModeTypeScaleAspectFit;
		[self reloadData];
		self.frame = full_screen_view_controller.view.bounds;

		[scroll_view setContentOffset:CGPointMake([self xPositionForIndex:page_control.currentPage], 0) animated:NO];
        [full_screen_view_controller.view addSubview:self];
        
        [animatedView removeFromSuperview];
		
	};
    
    [transitionAnimation fire];
	
    is_in_fullscreen = YES;
	fullscreen_tap_gesture_recognizer.numberOfTapsRequired = 1;
}

- (void)exitFullscreen
{
    HBALog(@"exiting fullscreen");
	
	page_control_background_view.hidden = NO;
	background_view.hidden = NO;
	
	self.frame = old_frame;
	[old_super_view addSubview:self];
	self.hbaContentModeType = old_hba_content_mode_type;
	[scroll_view setContentOffset:CGPointMake([self xPositionForIndex:page_control.currentPage], 0) animated:NO];
	
	
	HBAPaginatedPageView *currentPage = [page_views objectAtIndex:page_control.currentPage];
	currentPage.containerView.clipsToBounds = YES;
	currentPage.hbaContentModeType = self.hbaContentModeType;
	
	HBAAnimation *shrinkAnimation = [currentPage sizeChangeAnimationForNewFrame:[HBAViewTransitionAnimation windowRectOfView:self]];
	shrinkAnimation.duration = HBA_PAGINATED_VIEW_FULLSCREEN_TRANSITION_GROW_DURATION;
    
	HBAAnimation *lightenAnimation = [HBAAnimation animationOfView:full_screen_view_controller.view withAnimationBlock:^(UIView *animatedView, id context){
		
		full_screen_view_controller.view.alpha = 0;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
		
	}];
    lightenAnimation.duration = HBA_PAGINATED_VIEW_FULLSCREEN_TRANSITION_DARKEN_DURATION;
	
	HBAAnimationSequence *sequence = [HBAAnimationSequence sequenceWithAnimations:[NSArray arrayWithObjects: shrinkAnimation, lightenAnimation, nil]];
	
	HBAViewTransitionAnimation *transitionAnimation = [HBAViewTransitionAnimation transitionAnimationOfView:currentPage fromView:full_screen_view_controller.view toView:[UIApplication sharedApplication].keyWindow withAnimation:sequence sendingDelegate:self receivingDelegate:self];
	
	transitionAnimation.completionBlock = ^(UIView *animatedView, BOOL finished){
		
        [full_screen_view_controller.view removeFromSuperview];
		
		[self reloadData];
		self.alpha = 1;
	};
    
	self.alpha = 0;
   [transitionAnimation fire];
    
	is_in_fullscreen = NO;
	fullscreen_tap_gesture_recognizer.numberOfTapsRequired = 2;
}

- (CGRect) windowRectForView:(UIView*)outgoingView
{
	if (is_in_fullscreen)
		return full_screen_view_controller.view.bounds;
	else 
		return [HBAViewTransitionAnimation windowRectOfView:self];
}

- (CGRect) destinationRectForView:(UIView*)incomingView
{
	if (is_in_fullscreen)
		return self.frame;
	else 
		return incomingView.frame;
}

#pragma mark -
#pragma mark Property Overrides

- (void)setDataState:(HBADataState)theDataState
{
	if (data_state == theDataState)
		return;
	
	data_state = theDataState;
	
	if (data_state == HBADataStateNoResults)
	{
		[self setViewToNoResults];
	}
	else if (data_state == HBADataStateLoading)
	{
		[self setViewToLoading];
	}
	else if (data_state == HBADataStateHasData)
	{
		[self reloadData];
	}
}

- (void)setDataSource:(id<HBAPaginatedViewScrollViewDataSource, NSObject>)theDataSource
{
	if (data_source == theDataSource)
		return;
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:HBA_NOTIFICATION_DATA_CHANGED object:data_source];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:HBA_NOTIFICATION_DATA_IS_LOADING object:data_source];
	data_source = theDataSource;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDataState) name:HBA_NOTIFICATION_DATA_CHANGED object:data_source];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDataState) name:HBA_NOTIFICATION_DATA_IS_LOADING object:data_source];
	
	[self setDataState];
}

- (CGRect)maximumSizedFrameForContentView
{
	CGRect maxFrame = CGRectMake(self.leftMargin, self.topMargin, self.frame.size.width - self.leftMargin - self.rightMargin, self.frame.size.height - self.topMargin - self.bottomMargin - HBA_PAGINATED_VIEW_SCROLL_VIEW_PAGE_CONTROL_HEIGHT);
    
    HBALogRect(maxFrame);
    
	return maxFrame;
}

- (void)setCaptionsOn:(BOOL)captionsOn
{
    captions_on = captionsOn;
    
    if (captions_on)
    {
        [self addGestureRecognizer:caption_tap_gesture_recognizer];
    }
    else 
    {
        [self removeGestureRecognizer:caption_tap_gesture_recognizer];
    }
}

- (void)setFullscreenOn:(BOOL)fullscreenOn
{
    fullscreen_on = fullscreenOn;
    
    if (fullscreen_on)
    {
        [self addGestureRecognizer:fullscreen_tap_gesture_recognizer];
    }
    else
    {
        [self removeGestureRecognizer:fullscreen_tap_gesture_recognizer];
    }
}

- (CGSize) pageSize
{
    CGSize result = CGSizeMake(self.frame.size.width, self.frame.size.height);
    return result;
}

- (void)setBackgroundView:(UIView *)newBackgroundView
{
	if (background_view == newBackgroundView)
		return;
	
	[background_view removeFromSuperview];
	
	background_view = newBackgroundView;
	[self insertSubview:background_view atIndex:0];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	page_control.currentPage = floor([self.dataSource numberOfPagesInPaginatedViewScrollView:self]*scrollView.contentOffset.x/scrollView.contentSize.width);
	
	[self setCurrentCaptionView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if ([(NSObject *)self.delegate respondsToSelector:@selector(paginatedViewScrollViewDidBeginScrolling:)])
	{
		[self.delegate paginatedViewScrollViewDidBeginScrolling:self];
	}
}

@end

