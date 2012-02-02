//
//  PLRequest.m
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLRequest.h"
#import "PLParser.h"

#import "PLUrlHelper.h"

@implementation PLRequest

- (id)initWithUrl:(NSURL *)url
{
	if (self = [super init])
	{
		url_request = [[NSMutableURLRequest alloc] initWithURL:url];
	}
	return self;
}

- (id)initWithUrl:(NSURL *)url andParserClass:(Class)parserClass
{
	if (self = [self initWithUrl:url])
	{
        parser_class = parserClass;
	}
	return self;
}

- (void)performRequestWithSuccessBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock
{
	success_block = [successBlock copy];
	failure_block = [failureBlock copy];
	
	url_connection = [[NSURLConnection alloc] initWithRequest:url_request delegate:self startImmediately:YES];
}

#pragma mark - 
#pragma mark NSURLConnectionDelegate Methods

/*- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
 {
 
 }*/

/*- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
 {
 
 }*/

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
	data = [[NSMutableData alloc] init];
	
	return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
	[data appendData:theData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (failure_block)
        failure_block(error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	id returnData = nil;
	if (parser_class)
	{
		PLParser *parser = [[parser_class alloc] initWithData:data];
		[parser parse];
		
		returnData = parser.data;
	}
	else 
	{
		returnData = data;
	}
	
	if (success_block)
		success_block(returnData);
}

@end
