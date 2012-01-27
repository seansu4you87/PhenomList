//
//  PLTableFooter.m
//  PhenomList
//
//  Created by Joe Taylor on 1/23/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLTableFooter.h"
#import "PLImageHelper.h"

@implementation PLTableFooter

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{        
        self.backgroundColor = [UIColor colorWithPatternImage:[PLImageHelper tableFooterImage]];
	}
	return self;
}
@end
