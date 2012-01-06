//
//  HBALogger.h
//  HBATouch
//
//  Created by Sean Yu on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//#ifdef DEBUG
# define HBALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//# define HBALog(...)
//#endif

#define HBALogRect(rect) HBALog(@"CGRect: (%f, %f, %f, %f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define HBALogPoint(point) HBALog(@"CGPoint: (%f, %f)", point.x, point.y)
#define HBALogSize(size) HBALog(@"CGSize: (%f, %f)", size.width, size.height)

@interface HBALogger : NSObject
{

}

@end
