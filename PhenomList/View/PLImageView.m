//
//  PLImageView.m
//  PhenomList
//
//  Created by Sean Yu on 1/31/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLImageView.h"
#import "PLApplicationData.h"

@interface PLImageView (private)

- (void)getImage;

@end

@implementation PLImageView

- (id)initWithImageUrl:(NSURL *)imageUrl
{
	if (self = [super initWithFrame:CGRectZero] )
	{
		self.backgroundColor = [UIColor whiteColor];
		
		image_url = imageUrl;
		image_view = [[UIImageView alloc] initWithFrame:CGRectZero];
		
		[self addSubview:image_view];
		
		[self getImage];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	image_view.frame = self.bounds;
}

- (void)getImage
{
	[[PLApplicationData singleton] getDataForUrl:image_url successBlock:^(id result){
		
		image_view.image = [[UIImage alloc] initWithData:result];
		
	}andFailureBlock:^(NSError *error){
		
		NSLog(@"BIG ERROR in getting image");
		
	}];
}

@end
