//
//  HBAPaginatedInnerPageView.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/27/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAPaginatedInnerPageView.h"
#import "HBAPaginatedInnerPageContentContainerView.h"

@interface HBAPaginatedInnerPageView (Private)

- (CGRect) contentContainerViewFrame;

@end

@implementation HBAPaginatedInnerPageView

@synthesize margins, contentContentMode, contentView;

- (void)dealloc
{

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = YES;
        margins = UIEdgeInsetsMake(0, 0, 0, 0);
        container_view = [[HBAPaginatedInnerPageContentContainerView alloc] initWithFrame:[self contentContainerViewFrame]];
        container_view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:container_view];
                          
                          
    }
    return self;
}

#pragma mark -
#pragma mark Layout

- (CGRect) contentContainerViewFrame
{
    CGRect result = CGRectMake(self.margins.left, 
                               self.margins.top, 
                               MAX(0, self.frame.size.width - self.margins.left - self.margins.right), 
                               MAX(0, self.frame.size.height - self.margins.top - self.margins.bottom));
    return result;
}

#pragma mark -
#pragma mark Property overrides

- (void) setMargins:(UIEdgeInsets)newMargins
{
    margins = newMargins;
    container_view.frame = [self contentContainerViewFrame];
}

- (void) setContentContentMode:(UIViewContentMode)newContentContentMode
{
    container_view.contentContentMode = newContentContentMode;
}

- (UIViewContentMode) contentContentMode
{
    return container_view.contentContentMode;
}

- (void) setContentView:(UIView *)newContentView
{
    container_view.contentView = newContentView;
}

- (UIView *) contentView
{
    return container_view.contentView;
}

- (void) setFrame:(CGRect)newFrame
{
    [super setFrame:newFrame];
    container_view.frame = [self contentContainerViewFrame];
}

@end
