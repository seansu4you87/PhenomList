//
//  HBACaptionView.m
//  HBATouch
//
//  Created by Sean Yu on 1/23/11.
//  Copyright 2011 TerriblyClever. All rights reserved.
//

#import "HBACaptionView.h"
#import "HBAViewGeometry.h"

#define HBA_CAPTION_VIEW_TOP_MARGIN 5
#define HBA_CAPTION_VIEW_BOTTOM_MARGIN 5

@implementation HBACaptionView

@synthesize titleLabel = title_label, subtitleLabel = subtitle_label;

- (void)dealloc 
{

}

- (id)initWithFrame:(CGRect)theFrame
{
	if (self = [super initWithFrame:theFrame])
	{
		self.backgroundColor = [UIColor clearColor];
		
		CGFloat horizontalMargin = 10;
		
		title_label = [[UILabel alloc] initWithFrame:CGRectMake(horizontalMargin, HBA_CAPTION_VIEW_TOP_MARGIN, theFrame.size.width - 2 * horizontalMargin, floor(theFrame.size.height / 2.0))];
		title_label.backgroundColor = [UIColor clearColor];
		title_label.font = [UIFont boldSystemFontOfSize:12];
		title_label.textColor = [UIColor whiteColor];
		title_label.textAlignment = UITextAlignmentCenter;
		title_label.numberOfLines = 0;
		
		subtitle_label = [[UILabel alloc] initWithFrame:CGRectMake(horizontalMargin, CGRectGetMaxY(title_label.frame), theFrame.size.width - 2 * horizontalMargin, floor(theFrame.size.height / 2.0))];
		subtitle_label.backgroundColor = [UIColor clearColor];
		subtitle_label.font = [UIFont systemFontOfSize:10];
		subtitle_label.textColor = [UIColor whiteColor];
		subtitle_label.textAlignment = UITextAlignmentCenter;
		subtitle_label.numberOfLines = 0;
		
		[self addSubview:title_label];
		[self addSubview:subtitle_label];
	}
	
	return self;
}

- (void)reframeLabels
{
	CGSize titleSize = [title_label.text sizeWithFont:title_label.font constrainedToSize:CGSizeMake(title_label.frame.size.width, 50) lineBreakMode:title_label.lineBreakMode];
	CGSize subtitleSize = [subtitle_label.text sizeWithFont:subtitle_label.font constrainedToSize:CGSizeMake(subtitle_label.frame.size.width, 1000) lineBreakMode:subtitle_label.lineBreakMode];
	
	HBAHeightChangeView(title_label, titleSize.height);
	HBAMoveYView(subtitle_label, CGRectGetMaxY(title_label.frame));
	HBAHeightChangeView(subtitle_label, subtitleSize.height);
	HBAHeightChangeView(self, titleSize.height + subtitleSize.height + HBA_CAPTION_VIEW_TOP_MARGIN + HBA_CAPTION_VIEW_BOTTOM_MARGIN);
}


- (void) drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef curContext = UIGraphicsGetCurrentContext();
	
	CGContextSetRGBFillColor(curContext, 0.0, 0.0, 0.0, 0.7f);
	CGContextFillRect(curContext, rect);
	
	CGContextSetRGBStrokeColor(curContext, 1.0, 1.0, 1.0, 0.8);
	
	CGContextMoveToPoint(curContext, 0, rect.size.height);
	CGContextAddLineToPoint(curContext, rect.size.width, rect.size.height);
	
	CGContextStrokePath(curContext);
}

@end
