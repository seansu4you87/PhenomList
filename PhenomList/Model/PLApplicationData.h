//
//  PLApplicationData.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLRequest.h"

@interface PLApplicationData : NSObject
{
    NSArray *lists;
}

+ (PLApplicationData *)singleton;

- (void)getListsWithSuccessBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock;

@end
