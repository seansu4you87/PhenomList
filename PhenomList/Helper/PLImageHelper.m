//
//  PLImageHelper.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLImageHelper.h"

@implementation PLImageHelper

+ (UIImage *)logoImage
{
    return [UIImage imageNamed:@"PLLogo.png"];
}

+ (UIImage *)navigationBarImage
{
    return [UIImage imageNamed:@"PLNavigationBar.png"];
}

+ (UIImage *)listCellImage
{
    return [UIImage imageNamed:@"PLTableCell.png"];
}

+ (UIImage *)listCellSelectedImage
{
    return [UIImage imageNamed:@"PLTableCellSelection.png"];
}

+ (UIImage *)tableFooterImage
{
    return [UIImage imageNamed:@"PLTableFooterImage.png"];
}

+ (UIImage *)tableHeaderImage
{
    return [UIImage imageNamed:@"PLTableHeaderImage.png"];
}

+ (UIImage *)loadingImageForIndex:(NSInteger)i
{
    NSString *numString = (i < 10) ? @"0%i" : @"%i";
    numString = [NSString stringWithFormat:numString, i];
    
    return [UIImage imageNamed:[NSString stringWithFormat:@"PLLoading_%@", numString]];
}

@end
