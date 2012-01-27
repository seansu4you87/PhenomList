//
//  PLTableHeader.m
//  PhenomList
//
//  Created by Joe Taylor on 1/20/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLTableHeader.h"

#import "PLImageHelper.h"

@implementation PLTableHeader

+ (PLTableHeader *)tableHeader
{
    return [[PLTableHeader alloc] initWithFrame:CGRectMake(0, 0, 320, 280)];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{        
        self.backgroundColor = [UIColor colorWithPatternImage:[PLImageHelper tableHeaderImage]];
	}
	return self;
}

@end
