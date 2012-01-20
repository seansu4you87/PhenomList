//
//  PLListCellSelection.m
//  PhenomList
//
//  Created by Joe Taylor on 1/20/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLListCellSelection.h"
#import "InnerShadowDrawing.h"

@implementation PLListCellSelection

@synthesize shadowSize = shadow_size;
@synthesize shadowBlur = shadow_blur;
@synthesize shadowColor = shadow_color;

/*
 CGSize shadowSize, 
 CGFloat shadowBlur, 
 UIColor *shadowColor
*/


- (id)initWithInnerShadowSize:(CGSize)shadowSize blur:(CGFloat)shadowBlur rect:(CGRect)rect andColor:(UIColor*)shadowColor
{
	if (self = [super initWithFrame:rect])
	{
        self.shadowSize = shadowSize;
        self.shadowBlur = shadowBlur;
        self.shadowColor = shadowColor;
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PLTableCellSelection.png"]];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
    drawWithInnerShadow(rect, self.shadowSize, self.shadowBlur, self.shadowColor,
                        ^ {
                            CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(1, 1, rect.size.width-2, self.frame.size.height-2));
                        },
                        ^ {
                            [[UIColor clearColor] set];
                            CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(1, 1, rect.size.width-2, self.frame.size.height-2));
                        });
    [super drawRect:rect];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
