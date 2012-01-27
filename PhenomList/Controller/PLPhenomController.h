//
//  PLPhenomController.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

//#import <UIKit/UIKit.h"

@class PLPhenom;

@interface PLPhenomController : UIViewController
{
    PLPhenom *phenom;
}

- (id)initWithPhenom:(PLPhenom *)thePhenom;

@end
