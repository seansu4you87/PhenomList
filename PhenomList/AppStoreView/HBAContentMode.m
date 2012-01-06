//
//  HBAContentMode.m
//  HBATouch
//
//  Created by Sean Yu on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HBAContentMode.h"
#import "HBAViewGeometry.h"

@implementation HBAContentMode

+ (BOOL) doesContentModeScale:(UIViewContentMode)contentMode
{
    BOOL result = contentMode == UIViewContentModeScaleToFill
               || contentMode == UIViewContentModeScaleAspectFit
               || contentMode == UIViewContentModeScaleAspectFill;
    
    return result;
}

+ (CGRect) frameForContentSize:(CGSize)initialSize 
               containedInSize:(CGSize)containerSize 
                      withMode:(UIViewContentMode)contentMode
{
    CGPoint containerCenter = CGPointMake(containerSize.width/2.0, containerSize.height/2.0);
    CGRect result = [HBAViewGeometry rectOfSize:initialSize centeredAroundPoint:containerCenter];
    
    if([self doesContentModeScale:contentMode])
    {
        switch (contentMode) {
            case UIViewContentModeScaleToFill:
            {
                result = CGRectMake(0, 0, containerSize.width, containerSize.height);
                break;
            }
            case UIViewContentModeScaleAspectFit:
            case UIViewContentModeScaleAspectFill:
            {
                float widthRatio = containerSize.width/initialSize.width;
                float heightRatio = containerSize.height/initialSize.height;
                
                if(containerSize.width == 0 && initialSize.width == 0)
                    widthRatio = 1;
                if(containerSize.height == 0 && initialSize.height == 0)
                    heightRatio = 1;
                
                BOOL widthMoreExtreme = fabs(widthRatio - 1) > fabs(heightRatio - 1);
                float ratio = widthMoreExtreme ? widthRatio : heightRatio;
                if(contentMode == UIViewContentModeScaleAspectFill)
                    ratio = widthMoreExtreme ? heightRatio : widthRatio;
                
                CGSize newSize = CGSizeMake(initialSize.width*ratio, initialSize.height*ratio);
                result = [HBAViewGeometry rectOfSize:newSize centeredAroundPoint:containerCenter];
                
                break;
            }
            default:
                break;
            
        }
    }else
    {
        
    }
    
    result = HBAFloorFrame(result);
    
    return result;
}

@end
