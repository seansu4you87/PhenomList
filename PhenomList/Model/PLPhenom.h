//
//  PLPerson.h
//  PhenomList
//
//  Created by Sean Yu on 12/21/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLObject.h"

@interface PLPhenom : PLObject
{
	NSDate                  *date;
	
	NSString				*name;
	NSString				*lead;
	NSString				*content;

	NSURL                   *image_url;
	NSURL                   *video_url;
	
	NSMutableDictionary     *stats;
	
	NSInteger               votes;
}

@property(nonatomic, retain) NSDate *date;
@property(nonatomic, retain) NSString *name, *lead, *content;
@property(nonatomic, retain) NSURL *imageURL, *videoURL;
@property(nonatomic, retain) NSMutableDictionary *stats;
@property(nonatomic, assign) NSInteger votes;

@end
