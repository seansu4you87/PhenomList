//
//  PLApplicationData.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLApplicationData.h"
#import "PLList.h"
#import "PLListParser.h"
#import "PLListDetailParser.h"

#import "PLUrlHelper.h"

@interface PLApplicationData (private)

@end

@implementation PLApplicationData

PLApplicationData *appData;
+ (PLApplicationData *)singleton
{
    if (appData == nil)
        appData = [[PLApplicationData alloc] init];
    
    return appData;
}

- (id)init
{
    if (self = [super init])
    {
		cache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (PLList *)listWithUid:(NSInteger)uid
{
    for (PLList *list in lists)
    {
        if (list.uid == uid)
            return list;
    }
    
    return nil;
}

- (void)getListsWithSuccessBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock
{
    if (lists)
    {
        successBlock(lists);
        return;
    }
    
    PLRequest *request = [[PLRequest alloc] initWithUrl:[PLUrlHelper listsUrl] andParserClass:[PLListParser class]];
    [request performRequestWithSuccessBlock:^(id result){
        
        lists = result;
        successBlock(result);
        
    }andFailureBlock:failureBlock];
}

- (void)getDetailForList:(PLList *)list successBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock
{
    if (list.summary && [list.phenoms count])
    {
        successBlock(list);
        return;
    }
    
    PLRequest *request = [[PLRequest alloc] initWithUrl:[PLUrlHelper listDetailUrlForListId:list.uid] andParserClass:[PLListDetailParser class]];
    [request performRequestWithSuccessBlock:^(id result){
        
        PLList *resultList = (PLList *)result;
        PLList *cachedList = [self listWithUid:resultList.uid];
        
        [cachedList fillWithDataFromList:resultList];
        
        successBlock(cachedList);
        
    }andFailureBlock:failureBlock];
}

- (void)getDataForUrl:(NSURL *)url successBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock
{
	id cachedData = [cache objectForKey:[url absoluteString]];
	if (cachedData)
	{
		successBlock(cachedData);
		return;
	}
	
	PLRequest *request = [[PLRequest alloc] initWithUrl:url];
	[request performRequestWithSuccessBlock:^(id result){
		
		[cache setObject:result forKey:[url absoluteString]];
		successBlock(result);
		
	}andFailureBlock:failureBlock];
}

@end
