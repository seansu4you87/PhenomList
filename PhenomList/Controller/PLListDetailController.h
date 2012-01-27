//
//  PLListDetailController.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLList;

@interface PLListDetailController : UITableViewController
{
    PLList *list;
}

- (id)initWithList:(PLList *)theList;

@end
