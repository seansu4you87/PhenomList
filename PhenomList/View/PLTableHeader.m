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

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{        
        self.backgroundColor = [UIColor colorWithPatternImage:[PLImageHelper tableHeaderImage]];
	}
	return self;
}

@end
