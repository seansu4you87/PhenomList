//
//  PLImageHelper.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLImageHelper : NSObject

+ (UIImage *)logoImage;
+ (UIImage *)navigationBarImage;
+ (UIImage *)listCellImage;
+ (UIImage *)listCellSelectedImage;
+ (UIImage *)tableFooterImage;
+ (UIImage *)tableHeaderImage;
+ (UIImage *)largePhotoFrame;
+ (UIImage *)loadingImageForIndex:(NSInteger)i;

@end
