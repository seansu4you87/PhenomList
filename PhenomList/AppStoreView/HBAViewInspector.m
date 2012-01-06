//
//  HBAViewInspector.m
//  HBATouch
//
//  Created by Benjamin Cunningham on 12/18/10.
//  Copyright 2010 Sqr11. All rights reserved.
//

#import "HBAViewInspector.h"

@implementation HBAViewInspector

+(NSString *)stringPad:(int)numPad 
{
	NSMutableString *pad = [NSMutableString stringWithCapacity:1024];
	for (int i=0; i<numPad; i++) {
		[pad appendString:@"  "];
	}
	return pad; 
}

+ (BOOL) view:(UIView*)theView isSubclassOfClassString:(NSString*)nameOfClass
{
	return [[theView classForCoder] isSubclassOfClass:NSClassFromString(nameOfClass)];
}

+ (UIView*) subviewOfView:(UIView*)topView withClassName:(NSString*)nameOfClass
{
	if([self view:topView isSubclassOfClassString:nameOfClass])
		return topView;
	
	for(UIView * subview in topView.subviews)
	{
		UIView * result = [self subviewOfView:subview withClassName:nameOfClass];
		if(result)
			return result;
	}
	
	return nil;
}

+ (void)inspectView: (UIView *)theView depth:(int)depth path:(NSString *)path
{
	if (depth==0) {
		NSLog(@"-------------------- <view hierarchy> -------------------");
	}
	
	NSString *pad = [self stringPad:depth];
	
	// print some information about the current view
	//
	NSLog(@"%@", [NSString stringWithFormat:@"%@.description: %@",pad,[theView description]]);
	if ([theView isKindOfClass:[UIImageView class]]) {
		NSLog(@"%@", [NSString stringWithFormat:@"%@.class: UIImageView",pad]);
	} else if ([theView isKindOfClass:[UILabel class]]) {
		NSLog(@"%@", [NSString stringWithFormat:@"%@.class: UILabel",pad]);
		NSLog(@"%@", [NSString stringWithFormat:@"%@.text: ",pad,[(UILabel *)theView text]]);		
	} else if ([theView isKindOfClass:[UIButton class]]) {
		NSLog(@"%@", [NSString stringWithFormat:@"%@.class: UIButton",pad]);
		NSLog(@"%@", [NSString stringWithFormat:@"%@.title: ",pad,[(UIButton *)theView titleForState:UIControlStateNormal]]);		
	}
	
	NSLog(@"%@", [NSString stringWithFormat:@"%@.frame: %.0f, %.0f, %.0f, %.0f", pad, theView.frame.origin.x, theView.frame.origin.y,
			theView.frame.size.width, theView.frame.size.height]);
	NSLog(@"%@", [NSString stringWithFormat:@"%@.subviews: %d",pad, [theView.subviews count]]);
	NSLog(@" ");
	
	// gotta love recursion: call this method for all subviews
	//
	for (int i=0; i<[theView.subviews count]; i++) {
		NSString *subPath = [NSString stringWithFormat:@"%@/%d",path,i];
		NSLog(@"%@", [NSString stringWithFormat:@"%@--subview-- %@",pad,subPath]);		
		[self inspectView:[theView.subviews objectAtIndex:i]  depth:depth+1 path:subPath];
	}
	
	if (depth==0) {
		NSLog(@"-------------------- </view hierarchy> -------------------");
	}
}

+ (void)inspectView:(UIView*)theView
{
	[self inspectView:theView depth:0 path:@""];
}

@end
