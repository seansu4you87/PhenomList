//
//  HBANotificationCenter.h
//  HBATouch
//
//  Created by Sean Yu on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HBA_NOTIFICATION_DATA_CHANGED @"data has changed"
#define HBA_NOTIFICATION_DATA_IS_LOADING @"data is loading"


@interface HBANotificationCenter : NSObject 
{

}

+ (void) postNotificationForType:(int)theType;
+ (void) postNotificationForType:(int)theType withObject:(id)theObject;
+ (void) postNotificationForType:(int)theType withObject:(id)theObject userInfo:(NSDictionary *)theUserInfo;

+ (void) addObserver:(id<NSObject>)theObserver forNotificationType:(int)theType;
+ (void) removeObserver:(id<NSObject>)theObserver forNotificationType:(int)theType;

//subclasses must implement these
+ (NSString *) notificationNameForNotificationType:(int)theType;
+ (SEL) receivingSelectorForNotificationType:(int)theType;

@end
