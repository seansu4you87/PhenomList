//
//  HBAViewGeometry.h
//  HBATouch
//
//  Created by Sean Yu on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface HBAViewGeometry : NSObject
{
	
}


+ (void) pushView:(UIView*)theView byX:(float)dx Y:(float)dy;
+ (CGRect) rectOfSize:(CGSize)theSize centeredAroundPoint:(CGPoint)thePoint;
//Frame and View Changing

#define HBAFloorFrame(inputFrame) CGRectMake(floor(inputFrame.origin.x), floor(inputFrame.origin.y), floor(inputFrame.size.width), floor(inputFrame.size.height))

//origin
#define HBAMoveFrame(frame, x, y) CGRectMake(x, y, frame.size.width, frame.size.height)
#define HBAMoveView(view, x, y) view.frame = HBAMoveFrame(view.frame, x, y)

#define HBAMoveXFrame(frame, x) HBAMoveFrame(frame, x frame.origin.y)
#define HBAMoveXView(view, x) view.frame = HBAMoveXFrame(view.frame, x)

#define HBAMoveYFrame(frame, y) HBAMoveFrame(frame, frame.origin.x, y)
#define HBAMoveYView(view, y) view.frame = HBAMoveYFrame(view.frame, y)

#define HBATranslateFrame(frame, dx, dy) HBAMoveFrame(frame, frame.origin.x + dx, frame.origin.y + dy)
#define HBATranslateView(view, dx, dy) view.frame = HBATranslateFrame(view.frame, dx, dy)

#define HBACenterFrameAHorizontallyInFrameB(a, b) HBAMoveFrame(a, floor(b.origin.x + (b.size.width - a.size.width)/2.0), a.origin.y)
#define HBACenterViewAHorizontallyInViewB(a, b) a.frame = HBACenterFrameAHorizontallyInFrameB(a.frame, b.frame)

#define HBACenterFrameAVerticallyInFrameB(a, b) HBAMoveFrame(a, a.origin.x, floor(b.origin.y + (b.size.height - a.size.height)/2.0))
#define HBACenterViewAVerticallyInViewB(a, b) a.frame = HBACenterFrameAVerticallyInFrameB(a.frame, b.frame)

#define HBACenterFrameAInFrameB(a, b) HBACenterFrameAVerticallyInFrameB(HBACenterFrameAHorizontallyInFrameB(a, b), b)
#define HBACenterViewAInViewB(a, b) a.frame = HBACenterFrameAInFrameB(a.frame, b.frame)


//size
#define HBASizeChangeFrame(frame, width, height) CGRectMake(frame.origin.x, frame.origin.y, width, height)
#define HBASizeChangeView(view, width, height) view.frame = HBASizeChangeFrame(view.frame, width, height)

#define HBAWidthChangeFrame(frame, width) HBASizeChangeFrame(frame, width, frame.size.height)
#define HBAWidthChangeView(view, width) view.frame = HBAWidthChangeFrame(view.frame, width)

#define HBAHeightChangeFrame(frame, height) HBASizeChangeFrame(frame, frame.size.width, height)
#define HBAHeightChangeView(view, height) view.frame = HBAHeightChangeFrame(view.frame, height)

#define HBAGrowFrame(frame, dw, dh) HBASizeChangeFrame(frame, frame.size.width + dw, frame.size.height + dh)
#define HBAGrowView(view, dw, dh) view.frame = HBAGrowFrame(view.frame, dw, dh)

#define HBAScaleFrame(frame, scaleFactor) CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * scaleFactor, frame.size.height * scaleFactor)
#define HBAScaleView(view, scaleFactor) view.frame = HBAScaleFrame(view.frame, scaleFactor)

//Other
CGRect HBAScaleFrameToFitInFrame(CGRect toScale,CGRect maxFrame);
CGRect HBAScaleFrameToFillFrame(CGRect toScale, CGRect maxFrame);

#define HBAScaleViewToFitInFrame(view, maxFrame) view.frame = HBAScaleFrameToFitInFrame(view.bounds, maxFrame)

@end