    //
//  HBAFullscreenViewController.m
//  HBATouch
//
//  Created by Sean Yu on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HBAFullscreenViewController.h"

@implementation HBAFullscreenViewController

- (void)dealloc 
{
	
}

- (id)init
{
	if ( (self = [super init]) )
	{
		
	}
	return self;
}

- (void)loadView
{
	UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	theView.backgroundColor = [UIColor blackColor];
	
	self.view = theView;
}

- (void)viewDidUnload 
{
	[super viewDidUnload];
}

@end
