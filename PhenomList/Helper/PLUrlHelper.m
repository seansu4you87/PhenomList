//
//  PLURL.m
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLUrlHelper.h"

@implementation PLUrlHelper

+ (PLUrlHelper *)listsUrl
{
	return [NSURL URLWithString:@"http://phenomlist.com/api/lists"];
}

+ (PLUrlHelper *)listDetailUrlForListId:(NSInteger)uid
{
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://phenomlist.com/api/list/%i", uid]];
}

@end
