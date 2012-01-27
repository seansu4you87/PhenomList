//
//  PLAppDelegate.h
//  PhenomList
//
//  Created by Sean Yu on 12/21/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLListController;

@interface PLAppDelegate : UIResponder <UIApplicationDelegate>
{
	PLListController *list_controller;
	UINavigationController *nav_controller;
}

@property (strong, nonatomic) UIWindow *window;

@end
