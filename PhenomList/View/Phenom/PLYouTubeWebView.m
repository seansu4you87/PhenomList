//
//  PLYouTubeWebView.m
//  PhenomList
//
//  Created by Sean Yu on 3/16/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLYouTubeWebView.h"

@implementation PLYouTubeWebView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
       /* NSURL *videoUrl = [NSURL URLWithString:@"http://www.youtube.com/watch?v=gczw0WRmHQU"];
        
        NSString *youTubeVideoHTML = @"<html><head>\
        <body style=\"margin:0\">\
        <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
        width=\"%0.0f\" height=\"%0.0f\"></embed>\
        </body></html>";
        
        NSString *html = [NSString stringWithFormat:youTubeVideoHTML, videoUrl, frame.size.width, frame.size.height];
        
        //[self loadHTMLString:html baseURL:nil];  */
        [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.youtube.com/embed/U-ixdjEiJjE?wmode=transparent"]]];
        
        self.scrollView.scrollEnabled = NO;
    }
    return self;
}

@end
