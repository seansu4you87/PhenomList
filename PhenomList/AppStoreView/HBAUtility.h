//
//  HBAUtility.h
//  HBATouch
//
//  Created by Sean Yu on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h> 
#import <CommonCrypto/CommonDigest.h>
#import "HBALogger.h"
#import "HBAViewGeometry.h"
#import "HBAViewInspector.h"

#define ifValueSetObjectForKeyInDictionary(object, key, dictionary) if (object !=nil && key != nil) [dictionary setObject:object forKey:key]

typedef enum
{
	HBADataStateInitial = 0,
	HBADataStateLoading = 1,
	HBADataStateNoResults,
	HBADataStateHasData
}HBADataState;

typedef NSString *(^HBAUtilityReturnStringBlock)(id object);

@interface HBAUtility : NSObject
{

}

#pragma mark - 
#pragma mark Device

+ (void)logDeviceInfo;

#pragma mark -
#pragma mark Invocations

+ (NSInvocation*) invocationWithTarget:(id)theTarget selector:(SEL)theSelector object:(id)theObject;
+ (NSInvocation*) invocationWithTarget:(id)theTarget selector:(SEL)theSelector;

#pragma mark -
#pragma mark Color

+ (UIColor*) darkerColorFromColor:(UIColor*)inputColor;

#pragma mark -
#pragma mark CoreGraphics

+ (BOOL) point:(CGPoint)thePoint isWithin:(float)distance ofPoint:(CGPoint)theOtherPoint;
+ (CGPoint) centerPointWithinView:(UIView*)theView;

#pragma mark -
#pragma mark Time

+ (NSString *)timeStringForSeconds:(double)seconds;

#pragma mark -
#pragma mark Alphabet

+ (NSArray *)uppercaseAlphabetArray;
+ (NSArray *)sectionedArrayFromArray:(NSArray *)objects withBlock:(HBAUtilityReturnStringBlock)returnStringBlock;

#pragma mark -
#pragma mark NSString

+ (NSString *)string:(NSString *)string toFitInSize:(CGSize)size withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode;
+ (NSString *)md5:(NSString *)string;
+ (BOOL)string:(NSString *)bigString contains:(NSString *)littleString;

#pragma mark -
#pragma mark UIView

+ (UIImage *)imageOfView:(UIView *)theView;
+ (UIImage*) stretchableRoundedRect;

#pragma mark - 
#pragma mark FileSystem

+ (NSString *)applicationDocumentsDirectory;

@end
