//
//  HBAPaginatedPageView.m
//  HBATouch
//
//  Created by Sean Yu on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HBAPaginatedPageView.h"

#import "HBAAnimation.h"

@implementation HBAPaginatedPageView

@synthesize topMargin = top_margin, bottomMargin = bottom_margin, leftMargin = left_margin, rightMargin = right_margin, contentView = content_view, containerView = container_view, hbaContentModeType = hba_content_mode_type;

- (void)dealloc
{

}

- (id)initWithFrame:(CGRect)frame
{
    if ( (self = [super initWithFrame:frame]) )
    {
		drop_shadow = [[UIImageView alloc] initWithFrame:self.bounds];
		drop_shadow.image = [[UIImage imageNamed:@"HBAImageShadow.png"] stretchableImageWithLeftCapWidth:42 topCapHeight:42];
		[self addSubview:drop_shadow];
    }
    return self;
}

- (HBAAnimation *)sizeChangeAnimationForNewFrame:(CGRect)newFrame
{	
	HBAAnimation *growAnimation = [HBAAnimation animationOfView:self withAnimationBlock:^(UIView *animatedView, id context){
		
		self.frame = newFrame;
		//content_view.frame = [HBAContentMode frameForFrame:content_view.frame toFitFrame:[self containerFrame] withContentModeType:self.hbaContentModeType];
		
	}];
	
	return growAnimation;
}

- (CGRect)containerFrame
{
	 CGSize maxSize = CGSizeMake(self.frame.size.width - self.leftMargin - self.rightMargin, self.frame.size.height - self.topMargin - self.bottomMargin);
	
	return CGRectMake(self.leftMargin, self.topMargin, maxSize.width, maxSize.height);
}

#pragma mark -
#pragma mark Property Overrides

- (void)setContentView:(UIView *)contentView
{
    if (content_view == contentView)
        return;
    
    [container_view removeFromSuperview];

    
    [content_view removeFromSuperview];

    
    content_view = contentView;
    content_view.frame = [self containerFrame];
	contentView.backgroundColor = [UIColor yellowColor];
	
	CGFloat shadowMargin = 7;
	
	drop_shadow.frame = CGRectMake(contentView.frame.origin.x - shadowMargin, contentView.frame.origin.y - shadowMargin, contentView.frame.size.width + 2 * shadowMargin, contentView.frame.size.height + 2 * shadowMargin);
    
    //content_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //container_view = [[HBAContentMode changeView:content_view toFitFrame:[self containerFrame] withContentModeType:self.hbaContentModeType] retain];
	//container_view.backgroundColor = [UIColor clearColor];
    
    //container_view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self addSubview:content_view];
}

@end
