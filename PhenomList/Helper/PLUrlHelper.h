//
//  PLURL.h
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLUrlHelper : NSURL

+ (PLUrlHelper *)listsUrl;
+ (PLUrlHelper *)listDetailUrlForListId:(NSInteger)uid;

@end
