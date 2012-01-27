//
//  PLApplicationData.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLRequest.h"

@class PLList;

@interface PLApplicationData : NSObject
{
    NSArray *lists;
}

+ (PLApplicationData *)singleton;

- (PLList *)listWithUid:(NSInteger)uid;
- (void)getListsWithSuccessBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock;
- (void)getDetailForList:(PLList *)list successBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock;

@end
