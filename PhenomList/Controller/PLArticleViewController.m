//
//  PLArticleViewController.m
//  PhenomList
//
//  Created by Sean Yu on 1/5/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLArticleViewController.h"

@implementation PLArticleViewController

- (id)init
{
	if (self = [super init])
	{
		
	}
	return self;
}

- (void)loadView
{
	[super loadView];
	
	paginated_image_scroll_view.dataSource = self;
}

#pragma mark - 
#pragma mark HBAPaginatedViewScrollViewDataSource methods

- (NSInteger)numberOfPagesInPaginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView
{
	return 5;
}

- (UIView *)paginatedViewScrollView:(HBAPaginatedViewScrollView *)paginatedViewScrollView contentViewForIndex:(NSInteger)index
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
	
	CGFloat red = (arc4random() % 256) / 256;
	CGFloat blue = (arc4random() % 256) / 256;
	CGFloat yellow = (arc4random() % 256) / 256;
	
	view.backgroundColor = [UIColor colorWithRed:red green:yellow blue:blue alpha:1.0];
	return view;
}

- (BOOL)isCurrentlyLoading
{
	return NO;
}

@end
