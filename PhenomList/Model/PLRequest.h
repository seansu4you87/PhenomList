//
//  PLRequest.h
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    PLDataStateNoResults,
    PLDataStateHasData,
    PLDataStateLoading
} PLDataState;

typedef void (^PLRequestSuccessBlock)(id); 
typedef void (^PLRequestFailureBlock)(NSError *); 

@interface PLRequest : NSObject
{
	NSURLConnection			*url_connection;
	NSMutableURLRequest     *url_request;
	NSMutableData			*data;
	PLRequestSuccessBlock	success_block;
	PLRequestFailureBlock	failure_block;
    
    Class                   parser_class;
}

- (id)initWithUrl:(NSURL *)url;
- (id)initWithUrl:(NSURL *)url andParserClass:(Class)parserClass;
- (void)performRequestWithSuccessBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock;

@end
