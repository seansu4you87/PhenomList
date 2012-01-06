//
//  HBAViewInspector.h
//  HBATouch
//
//  Created by Benjamin Cunningham on 12/18/10.
//  Copyright 2010 Sqr11. All rights reserved.
//

//I found this somewhere online, it's free to use

#import <Foundation/Foundation.h>


@interface HBAViewInspector : NSObject {

}

+ (void)inspectView:(UIView*)theView;
+ (UIView*) subviewOfView:(UIView*)topView withClassName:(NSString*)nameOfClass;

@end
