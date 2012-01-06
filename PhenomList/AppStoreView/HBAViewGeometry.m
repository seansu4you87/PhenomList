//
//  HBAViewGeometry.m
//  HBATouch
//
//  Created by Sean Yu on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HBAViewGeometry.h"

@implementation HBAViewGeometry

CGRect HBAScaleFrameToFitInFrame(CGRect toScale, CGRect maxFrame)
{
	CGFloat heightRatio = maxFrame.size.height / toScale.size.height;
	CGFloat widthRatio = maxFrame.size.width / toScale.size.width;
	
	CGFloat scaleFactor = MIN(heightRatio, widthRatio);
	
	return HBAScaleFrame(toScale, scaleFactor);
}

CGRect HBAScaleFrameToFillFrame(CGRect toScale, CGRect maxFrame)
{	
	CGFloat widthToHeightRatio = maxFrame.size.width / maxFrame.size.height;
	
	CGFloat scaleFactor = 0;
	if (widthToHeightRatio < 1.0)
	{
		scaleFactor = maxFrame.size.height / toScale.size.height;
	}
	else 
	{
		scaleFactor = maxFrame.size.width / toScale.size.width;
	}
    
	return HBAScaleFrame(toScale, scaleFactor);
}

+ (void) pushView:(UIView*)theView byX:(float)x Y:(float)y
{
	CGRect newFrame = CGRectMake(theView.frame.origin.x + x, theView.frame.origin.y + y, theView.frame.size.width, theView.frame.size.height);
	theView.frame = newFrame;
}


+ (CGRect) rectOfSize:(CGSize)theSize centeredAroundPoint:(CGPoint)thePoint
{
    CGRect result = CGRectMake(thePoint.x - theSize.width/2.0, 
                               thePoint.y - theSize.height/2.0, 
                               theSize.width, 
                               theSize.height);
    
    return result;
}

@end
