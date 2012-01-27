//
//  PLApplicationData.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLApplicationData.h"
#import "PLUrlHelper.h"
#import "PLListParser.h"

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
        
    }
    return self;
}

- (void)getListsWithSuccessBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock
{
    if (lists)
    {
        successBlock(lists);
        return;
    }
    
    PLRequest *request = [[PLRequest alloc] initWithURL:[PLUrlHelper listsUrl] andParserClass:[PLListParser class]];
    [request performRequestWithSuccessBlock:^(id result){
        
        lists = result;
        successBlock(result);
        
    }andFailureBlock:failureBlock];
}

@end
