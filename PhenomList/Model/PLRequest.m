//
//  PLRequest.m
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLRequest.h"
#import "PLURL.h"

@implementation PLRequest

- (id)initWithURL:(PLURL *)url
{
	if (self = [super init])
	{
		url_request = [[NSMutableURLRequest alloc] initWithURL:url];
	}
	return self;
}

- (void)performRequestWithSuccessBlock:(PLRequestSuccessBlock)successBlock andFailureBlock:(PLRequestFailureBlock)failureBlock
{
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

/*- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
        
}*/

/*- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
       
}*/

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
        
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
}

@end
