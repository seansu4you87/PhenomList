//
//  PLCategory.h
//  PhenomList
//
//  Created by Sean Yu on 12/21/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLObject.h"

@interface PLList : PLObject
{
	NSDate          *date_created;
	NSDate          *date_updated;

	NSString		*title;
	NSString		*summary;
	
	NSMutableArray  *phenoms;
}

@property(nonatomic, strong) NSDate *dateCreated, *dateUpdated;
@property(nonatomic, strong) NSString *title, *summary;
@property(nonatomic, strong, readonly) NSMutableArray *phenoms;

- (void)fillWithDataFromList:(PLList *)list;

@end
