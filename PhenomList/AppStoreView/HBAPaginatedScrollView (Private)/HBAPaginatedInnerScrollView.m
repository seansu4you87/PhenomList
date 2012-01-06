//
//  HBAPaginatedInnerScrollView.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/27/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAPaginatedInnerScrollView.h"
#import "HBAPaginatedInnerPageView.h"

@interface HBAPaginatedInnerScrollView (Private)

- (CGSize) pageSize;
- (CGSize) scrollViewContentSize;
- (CGRect) pageFrameAtIndex:(int)index;
- (CGPoint) contentOffsetForPageIndex:(int)index inFrame:(CGRect)newFrame;
- (CGPoint) contentOffsetForPageIndex:(int)index;

- (void) addPageViewForPage:(int)pageIndex;
- (BOOL) hasPageViewForPage:(int)pageIndex;
- (HBAPaginatedInnerPageView*) pageViewAtIndex:(int)pageIndex;
- (void) setCurrentPage:(int)pageIndex;
- (void) removePageViewAtIndex:(int)pageIndex;

@end

@implementation HBAPaginatedInnerScrollView

@synthesize dataSource = data_source;
@synthesize parentScrollView = parent_scroll_view;
@synthesize currentPage = current_page;
@synthesize isActive = is_active, preloads;

- (void)dealloc
{
    parent_scroll_view = nil;
    data_source = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        is_active = YES;
        preloads = YES;
        current_page = 0;
        page_views = [NSMutableDictionary dictionaryWithCapacity:0];
        self.backgroundColor = [UIColor purpleColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        self.alwaysBounceVertical = NO;
        self.alwaysBounceHorizontal = YES;
        self.delegate = self;
    }
    return self;
}



#pragma mark -
#pragma mark DataSource interaction

- (int) numPages
{
    int result = [self.dataSource numberOfPagesInPaginatedScrollView:self.parentScrollView];
    return result;
}

- (UIView*) contentViewForPageAtIndex:(int)index
{
    UIView * result = [self.dataSource paginatedScrollView:self.parentScrollView contentViewForIndex:index];
    return result;
}

- (UIViewContentMode) contentModeForPageAtIndex:(int)index
{
    UIViewContentMode result = [self.dataSource paginatedScrollView:self.parentScrollView 
                                          contentModeForViewAtIndex:index];
    return result;
}

#pragma mark -
#pragma mark View management

- (UIColor*) debugColorForIndex:(int)index
{
    UIColor * result = [UIColor clearColor];
    
    switch (index % 3) {
        case 0:
        {
            result = [UIColor yellowColor];
            break;
        }
        case 1:
        {
            result = [UIColor orangeColor];
            break;
        }
        case 2:
        {
            result = [UIColor redColor];
            break;
        }
            
    }
    
    return result;
}

- (HBAPaginatedInnerPageView*) newPageViewForIndex:(int)index
{
    HBAPaginatedInnerPageView * result = [[HBAPaginatedInnerPageView alloc] initWithFrame:[self pageFrameAtIndex:index]];
    result.contentView = [self contentViewForPageAtIndex:index];
    //result.backgroundColor = [self debugColorForIndex:index];
    
    return result;
}

- (void) addAllViews
{
    int nPages = [self numPages];
    for(int i = 0; i < nPages; i++)
    {
        [self addPageViewForPage:i];
    }
}

- (void) updateScrollViewProperties
{
    self.contentSize = [self scrollViewContentSize];
}

- (NSArray*) allIndices
{
    int nPages = [self numPages];
    NSMutableArray * result = [NSMutableArray arrayWithCapacity:nPages];
    
    for(int i = 0; i < nPages; i++)
    {
        NSNumber * curIndex = [NSNumber numberWithInt:i];
        [result addObject:curIndex];
    }
    
    return result;
}

- (void) removePagesAtIndices:(NSArray*)pageNumbers
{
    for(NSNumber* pageNumber in pageNumbers)
    {
        int curIndex = [pageNumber intValue];
        [self removePageViewAtIndex:curIndex];
    }
}

- (void) reloadData
{
    NSArray * indices = [self allIndices];
    [self reloadDataAtIndices:indices];
}

- (void) reloadDataAtIndices:(NSArray*)pageNumbers
{
    [self removePagesAtIndices:pageNumbers];
    [self updateScrollViewProperties];
    [self setCurrentPage:current_page];
}

- (void) reloadDataAtIndex:(int)pageIndex
{
    NSArray * singleNumber = [NSArray arrayWithObject:[NSNumber numberWithInt:pageIndex]];
    [self reloadDataAtIndices:singleNumber];
}

- (UIView*) contentViewAtIndex:(int)pageIndex
{
    HBAPaginatedInnerPageView * pageView = [self pageViewAtIndex:pageIndex];
    
    if(!pageView)
    {
        NSLog(@"ERROR: asking for content view at index that is not loaded");
        return nil;
    }
    
    UIView * result = pageView.contentView;
    return result;
}

- (void) updatePageFrames
{
    int nPages = [self numPages];
    for(int i = 0; i < nPages; i++)
    {
        if([self hasPageViewForPage:i])
        {
            HBAPaginatedInnerPageView * pageView = [self pageViewAtIndex:i];
            pageView.frame = [self pageFrameAtIndex:i];
        }
    }
}

- (void) snapContentOffsetAnimated:(BOOL)shouldAnimate
{
    [self setContentOffset:[self contentOffsetForPageIndex:current_page] animated:shouldAnimate]; 
}

- (void) snapContentOffsetAnimated:(BOOL)shouldAnimate forNewFrame:(CGRect)newFrame
{
    [self setContentOffset:[self contentOffsetForPageIndex:current_page inFrame:newFrame] animated:shouldAnimate];
}
        
#pragma mark -
#pragma mark Page Management

+ (NSString*) keyForPageIndex:(int)index
{
    NSString * result = [NSString stringWithFormat:@"page num:%d", index];
    return result;
}
         
- (HBAPaginatedInnerPageView*) pageViewAtIndex:(int)pageIndex
{
    NSString * key = [HBAPaginatedInnerScrollView keyForPageIndex:pageIndex];
    HBAPaginatedInnerPageView * pageView = [page_views objectForKey:key];
    return pageView;
}

- (BOOL) hasPageViewForPage:(int)pageIndex
{
    BOOL hasPage = [self pageViewAtIndex:pageIndex] != nil;
    return hasPage;
}
         
- (void) removePageViewAtIndex:(int)pageIndex
{
    HBAPaginatedInnerPageView * pageView = [self pageViewAtIndex:pageIndex];
    if(pageView)
    {
        [pageView removeFromSuperview];
        [page_views removeObjectForKey:[HBAPaginatedInnerScrollView keyForPageIndex:pageIndex]];
    }
}

- (void) addPageViewForPage:(int)pageIndex
{
    //NSLog(@"%@ adding page view for index %d", self.description, pageIndex);
    HBAPaginatedInnerPageView * newPageView = [self newPageViewForIndex:pageIndex];
    [self addSubview:newPageView];
    [page_views setObject:newPageView 
                   forKey:[HBAPaginatedInnerScrollView keyForPageIndex:pageIndex]];
}

- (void) addPageAtIndexIfNecessary:(int)index
{
    if(![self hasPageViewForPage:index] && index >= 0 && index < [self numPages])
    {
        [self addPageViewForPage:index];
    }
}

- (void) loadPageIfNecessary
{
    if(self.isActive)
    {
        [self addPageAtIndexIfNecessary:current_page];
        if(self.preloads)
        {
            [self addPageAtIndexIfNecessary:current_page - 1];
            [self addPageAtIndexIfNecessary:current_page + 1];
        }
    }
}

- (void) setCurrentPage:(int)curPage
{
    if(curPage >= [self numPages])
       curPage = [self numPages] - 1;
       
    BOOL isDifferent = curPage != current_page;
       
    current_page = curPage;
    
    //NSLog(@"setting current page:%d", current_page);
    
    if(isDifferent)
    {
        [self snapContentOffsetAnimated:YES];
        //NSLog(@"SNAPPING to page: %d", current_page);
    }
    
    [self loadPageIfNecessary];
}

#pragma mark -
#pragma mark Layout

- (CGSize) pageSize
{
    CGSize result = CGSizeMake(self.frame.size.width, self.frame.size.height);
    return result;
}

- (CGSize) scrollViewContentSize
{
    CGSize onePageSize = [self pageSize];
    CGSize result = CGSizeMake(onePageSize.width*[self numPages], onePageSize.height);
    return result;
}
                                           
- (CGRect) pageFrameAtIndex:(int)index                                           
{
    CGSize theSize = [self pageSize];
    CGRect result = CGRectMake(theSize.width*index, 0, theSize.width, theSize.height);
    
    return result;
}

                          
- (CGPoint) contentOffsetForPageIndex:(int)index
{
    CGPoint result = CGPointMake(index*[self pageSize].width, 0);
    return result;
}

- (CGPoint) contentOffsetForPageIndex:(int)index inFrame:(CGRect)newFrame
{
    CGPoint result = CGPointMake(index*newFrame.size.width, 0);
    return result;
}

#pragma mark -
#pragma Property overrides

- (NSDictionary*) pageViews
{
    NSDictionary * result = [NSDictionary dictionaryWithDictionary:page_views];
    return result;
}

- (void) setDataSource:(id<HBAPaginatedScrollViewDataSource>)newDataSource
{
    if(![newDataSource isEqual:data_source])
    {
        data_source = newDataSource;
        [self reloadData];
    }
}

- (void) setFrame:(CGRect)newFrame
{
    [super setFrame:newFrame];
    [self updateScrollViewProperties];
    [self updatePageFrames];
}

- (void) setIsActive:(BOOL)active
{
    is_active = active;
    [self loadPageIfNecessary];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setCurrentPage:floor(self.contentOffset.x/[self pageSize].width)];
}

@end
