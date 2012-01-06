//
//  HBAContentMode.h
//  HBATouch
//
//  Created by Sean Yu on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    HBAContentModeTypeScaleAspectFit,
    HBAContentModeTypeScaleAspectFill,
    HBAContentModeTypeScaleToFill
}HBAContentModeType;


@interface HBAContentMode : NSObject 
{
    
}

+ (BOOL) doesContentModeScale:(UIViewContentMode)contentMode;
+ (CGRect) frameForContentSize:(CGSize)initialSize 
               containedInSize:(CGSize)containerSize 
                      withMode:(UIViewContentMode)contentMode;

@end
