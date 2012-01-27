//
//  PLListDetailController.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLListDetailController.h"
#import "PLList.h"
#import "PLApplicationData.h"

@implementation PLListDetailController

- (id)initWithList:(PLList *)theList
{
    if (self = [super init])
    {
        list = theList;
        [[PLApplicationData singleton] getDetailForList:list successBlock:^(id result){
            
            
            
        } andFailureBlock:^(NSError *error){
            
            
        }];
    }
    return self;
}



@end
