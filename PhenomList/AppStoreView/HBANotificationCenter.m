//
//  HBANotificationCenter
//  HBATouch
//
//  Created by Sean Yu on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HBANotificationCenter.h"
#import "HBALogger.h"

@implementation HBANotificationCenter

+ (void) postNotificationForType:(int)theType
{
	//[self postNotificationForType:theType withObject:nil];
	[self postNotificationForType:theType withObject:nil userInfo:nil];
}

+ (void) postNotificationForType:(int)theType withObject:(id)theObject
{
	//NSString * notificationName = [self notificationNameForNotificationType:theType];
	
	//[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:theObject];
	[self postNotificationForType:theType withObject:theObject userInfo:nil];
}

+ (void) postNotificationForType:(int)theType withObject:(id)theObject userInfo:(NSDictionary *)theUserInfo
{
	NSString * notificationName = [self notificationNameForNotificationType:theType];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:theObject userInfo:theUserInfo];
}

+ (void) addObserver:(id<NSObject>)theObserver forNotificationType:(int)theType
{
	NSString * notificationName = [self notificationNameForNotificationType:theType];
	
	SEL receivingSelector = [self receivingSelectorForNotificationType:theType];
	
	if(![theObserver respondsToSelector:receivingSelector])
	{
		HBALog(@"ERROR: you are attempting to add an observer(%@) for notification type: '%@' to HBANotificationCenter(%@) that doesn't implement the proper notification receiving protocol", [theObserver description], [self notificationNameForNotificationType:theType], [self description]);
	}else {
		[[NSNotificationCenter defaultCenter] addObserver:theObserver selector:receivingSelector name:notificationName object:nil];
	}
}

+ (void) removeObserver:(id<NSObject>)theObserver forNotificationType:(int)theType
{
	NSString * notificationName = [self notificationNameForNotificationType:theType];
	
	[[NSNotificationCenter defaultCenter] removeObserver:theObserver name:notificationName object:nil];
}

//subclasses must implement these
+ (NSString *) notificationNameForNotificationType:(int)theType
{
	return nil;
}

+ (SEL) receivingSelectorForNotificationType:(int)theType
{
	return nil;
}

@end
