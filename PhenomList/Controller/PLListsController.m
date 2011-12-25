//
//  PLListsController.m
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLListsController.h"
#import "PLRequest.h"
#import "PLURL.h"
#import "PLListParser.h"

@implementation PLListsController

- (id)init
{
    if (self = [super init])
    {
        self.title = @"PhenomList";
        
        PLRequest *request = [[PLRequest alloc] initWithURL:[PLURL listsURL] andParserClass:[PLListParser class]];
        [request performRequestWithSuccessBlock:^(id result){
            
            
            
        }andFailureBlock:^(NSError *error){
            
            
            
        }];
    }
    return self;
}

@end
