//
//  HBAUtility.m
//  HBATouch
//
//  Created by Sean Yu on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HBAUtility.h"


@implementation HBAUtility

#pragma mark - 
#pragma mark Device

+ (void)logDeviceInfo
{
	HBALog(@"model: %@", [[UIDevice currentDevice] model]);
	//HBALog(@"device_id: %@", [[UIDevice currentDevice] uniqueIdentifier]);
	HBALog(@"%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]);
}

#pragma mark -
#pragma mark Invocations

+ (NSInvocation*) invocationWithTarget:(id)theTarget selector:(SEL)theSelector object:(id)theObject
{
	NSMethodSignature * methodSignature = [theTarget methodSignatureForSelector:theSelector];
	
	NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	
	[invocation setTarget:theTarget];
	[invocation setSelector:theSelector];
	if(theObject)
	{
		[invocation setArgument:&theObject atIndex:2];
	}
	
	return invocation;
}

+ (NSInvocation*) invocationWithTarget:(id)theTarget selector:(SEL)theSelector
{
	return [HBAUtility invocationWithTarget:theTarget selector:theSelector object:nil];
}

#pragma mark -
#pragma mark Color

+ (UIColor*) darkerColorFromColor:(UIColor*)inputColor
{
	CGColorRef backingColor = inputColor.CGColor;
	
	if(CGColorGetNumberOfComponents(backingColor) < 3)
	{
		NSLog(@"ERROR: the input color does not have at least 3 color components");
		return nil;
	}
	
	float factor = 0.75f;
	
	const float * components = CGColorGetComponents(backingColor);
	
	float originalRed = components[0];
	float originalGreen = components[1];
	float originalBlue = components[2];
	
	float newRed = originalRed * factor;
	float newGreen = originalGreen * factor;
	float newBlue = originalBlue * factor;
	
	return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:CGColorGetAlpha(backingColor)];
}

#pragma mark -
#pragma mark CoreGraphics

+ (BOOL) point:(CGPoint)thePoint isWithin:(float)distance ofPoint:(CGPoint)theOtherPoint
{
	return fabs(thePoint.x - theOtherPoint.x) < distance && fabs(thePoint.y - theOtherPoint.y) < distance;
}

+ (CGPoint) centerPointWithinView:(UIView*)theView
{
	CGPoint viewCenter = CGPointMake(CGRectGetMidX(theView.bounds), CGRectGetMidY(theView.bounds));
	
	return viewCenter;
}

#pragma mark -
#pragma mark Time

+ (NSString *)timeStringForSeconds:(double)totalSeconds
{
	int minutes = (int)(totalSeconds / 60);
	int seconds = (int)(totalSeconds) - minutes * 60;
	
	NSString *returnString = @"";
	if (minutes < 10)
		returnString = [returnString stringByAppendingString:@"0"];
	returnString = [returnString stringByAppendingFormat:@"%i:", minutes];
	
	if (seconds < 10)
		returnString = [returnString stringByAppendingString:@"0"];
	returnString = [returnString stringByAppendingFormat:@"%i", seconds];
	
	return returnString;
}

#pragma mark -
#pragma mark Alphabet

+ (NSArray *)uppercaseAlphabetArray
{
	return [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
}

+ (NSArray *)sectionedArrayFromArray:(NSArray *)objects withBlock:(HBAUtilityReturnStringBlock)returnStringBlock
{
	NSMutableArray *mutableResult = [NSMutableArray array];
	for (NSString *letter in [HBAUtility uppercaseAlphabetArray])
	{
		NSMutableArray *mutableSection = [NSMutableArray array];
		for (id object in objects)
		{
			if ([returnStringBlock(object) length])
			{
				NSString *firstLetter = [returnStringBlock(object) substringToIndex:1];
				if ([letter isEqualToString:[firstLetter uppercaseString]])
					[mutableSection addObject:object];
			}
		}
		
		NSArray *sortedSection = [mutableSection sortedArrayUsingComparator:^(id obj1, id obj2){
			
			return [[returnStringBlock(obj1) lowercaseString] compare:[returnStringBlock(obj2) lowercaseString]];
			
		}];
		
		[mutableResult addObject:sortedSection];
	}
	return [NSArray arrayWithArray:mutableResult];
}

#pragma mark -
#pragma mark NSString

+ (NSString *)string:(NSString *)string toFitInSize:(CGSize)size withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode
{
	if ([string length] == 0)
		return nil;
	
	CGFloat closestHeight = ceil(size.height / font.lineHeight) * font.lineHeight;
	size = CGSizeMake(size.width, closestHeight);
	
	int index = 1;
	int indexOfWhiteSpace = 0;
	BOOL stringFits = YES;
	while (stringFits)
	{
		if (index >= [string length])
			return string;
		
		NSString *testString = [string substringToIndex:index];
		if ([[testString substringFromIndex:[testString length] - 1] isEqualToString:@" "])
			indexOfWhiteSpace = index;
		
		CGSize sizeOfString = [testString sizeWithFont:font constrainedToSize:CGSizeMake(size.width, size.height + font.lineHeight) lineBreakMode:lineBreakMode];
		//NSLog(@"test size: %f, max size: %f", sizeOfString.height, size.height);
		
		
		
		if (sizeOfString.height > size.height)
			stringFits = NO;
		else 
			index++;
	}
	
	return [string substringToIndex:indexOfWhiteSpace];
}

+ (NSString *) md5: (NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];  
}

+ (BOOL)string:(NSString *)bigString contains:(NSString *)littleString
{
	if (littleString == nil)
		return YES;
	NSRange range = [bigString rangeOfString:littleString];
	return (range.location != NSNotFound);
}

#pragma mark -
#pragma mark UIView


//this function needs to be fixed up
//do not use yet
/*
+ (UIImage*) imageOfRect:(CGRect)captureRect ofView:(UIView*)theView
{
	CGFloat scale = 1;//[UIScreen mainScreen].scale;
	CGSize normalSize = theView.bounds.size;
	CGSize scaledSize = CGSizeMake(scale*normalSize.width, scale*normalSize.height);
	
	UIGraphicsBeginImageContext(scaledSize);
	[theView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	viewImage = [[[UIImage alloc] initWithCGImage:viewImage.CGImage scale:scale orientation:UIImageOrientationUp] autorelease];
	
	//CGSize imageSize = viewImage.size;
	//CGFloat imageScale = viewImage.scale;
	
	
	CGRect scaledRect = CGRectMake(scale*captureRect.origin.x, scale*captureRect.origin.y, scale*captureRect.size.width, scale*captureRect.size.height);
	
	CGImageRef captured = CGImageCreateWithImageInRect(viewImage.CGImage, scaledRect);

	UIImage * result = [[UIImage alloc] initWithCGImage:captured scale:scale orientation:UIImageOrientationUp];
	//CGSize resultSize = result.size;
	//CGFloat resultScale = result.scale;
    CGImageRelease(captured);
	
	return [result autorelease];
}
 */

+ (UIImage *)imageOfView:(UIView *)theView
{
	UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, 0.0f);
	
	[theView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return image;
}

+ (UIImage*) stretchableRoundedRect
{
	UIImage * source = [UIImage imageNamed:@"HBARoundedRect.png"];
	UIImage * stretchable = [source stretchableImageWithLeftCapWidth:25 topCapHeight:25];
	
	return stretchable;
}

#pragma mark - 
#pragma mark FileSystem

+ (NSString *)applicationDocumentsDirectory 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	
	return basePath;
}

@end
