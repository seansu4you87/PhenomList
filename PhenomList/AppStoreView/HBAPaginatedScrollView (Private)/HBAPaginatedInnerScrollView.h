//
//  HBAPaginatedInnerScrollView.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/27/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBAPaginatedScrollView.h"

@interface HBAPaginatedInnerScrollView : UIScrollView<UIScrollViewDelegate> {
    __weak HBAPaginatedScrollView * parent_scroll_view;
    NSMutableDictionary * page_views;
    id<HBAPaginatedScrollViewDataSource> data_source;
    
    int current_page;
    
    BOOL is_active;
    BOOL preloads;
}

@property(nonatomic, readonly) NSDictionary * pageViews;
@property(nonatomic, retain) id<HBAPaginatedScrollViewDataSource> dataSource;
@property(nonatomic, weak) HBAPaginatedScrollView * parentScrollView;
@property(nonatomic, readonly) int currentPage;
@property(nonatomic, assign) BOOL isActive, preloads;

- (void) reloadData;
- (void) reloadDataAtIndices:(NSArray*)pageNumbers;
- (void) reloadDataAtIndex:(int)pageIndex;
- (UIView*) contentViewAtIndex:(int)pageIndex;

- (void) loadPageIfNecessary;
- (void) snapContentOffsetAnimated:(BOOL)shouldAnimate;
- (void) snapContentOffsetAnimated:(BOOL)shouldAnimate forNewFrame:(CGRect)newFrame;

@end
