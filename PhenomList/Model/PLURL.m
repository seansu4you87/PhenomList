//
//  PLURL.m
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLURL.h"

@implementation PLURL

+ (PLURL *)listsURL
{
	return [NSURL URLWithString:@"http://phenomlist.com/api/lists"];
}

+ (PLURL *)listDetailURLForListID:(NSString *)listID
{
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://phenomlist.com/api/list/%@", listID]];
}

@end
