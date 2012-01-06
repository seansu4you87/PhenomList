//
//  HBAPaginatedInnerPageContentContainerView.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 4/27/11.
//  Copyright 2011 Sqr11. All rights reserved.
//

#import "HBAPaginatedInnerPageContentContainerView.h"
#import "HBAContentMode.h"

@implementation HBAPaginatedInnerPageContentContainerView

@synthesize contentView = content_view, contentContentMode = content_content_mode;
@synthesize desiredContentSize = desired_content_size;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor blackColor];
        self.contentContentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)dealloc
{

}

#pragma mark -
#pragma mark Layout

- (CGRect) contentViewFrame
{
    CGRect result = [HBAContentMode frameForContentSize:self.desiredContentSize 
                                        containedInSize:self.frame.size
                                               withMode:self.contentContentMode];
    return result;
    
}

- (void) updateContentView
{
    if(content_view)
    {
        content_view.frame = [self contentViewFrame];
    }
}

#pragma mark -
#pragma mark Property overrides

- (void) setContentView:(UIView *)newContentView
{
    [content_view removeFromSuperview];

    content_view = newContentView;
    
    if(content_view)
    {
        desired_content_size = CGSizeMake(content_view.frame.size.width, content_view.frame.size.height);
        [self addSubview:content_view];
        [self updateContentView];
    }
}

- (void) setContentContentMode:(UIViewContentMode)newContentContentMode
{
    content_content_mode = newContentContentMode;
    
    [self updateContentView];
}

- (void) setFrame:(CGRect)newFrame
{
    [super setFrame:newFrame];
    [self updateContentView];
}

- (CGSize) desiredContentSize
{
    float aspectRatio = desired_content_size.width/desired_content_size.height;
    float greaterRatio = MAX(aspectRatio, 1.0/aspectRatio);
    BOOL notTooExtreme = fabs(greaterRatio) < 10;//otherwise indicates that something is likely wrong
    
    if(desired_content_size.width > 0 && desired_content_size.height > 0 && notTooExtreme)
        return desired_content_size;
    
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

@end
