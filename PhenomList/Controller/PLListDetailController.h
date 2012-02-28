//
//  PLListDetailController.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLList;
@class PLListDetailView;

@interface PLListDetailController : UIViewController
{
    PLList *list;
    
    PLListDetailView *detail_view;
}

@property(nonatomic, readonly) UIScrollView *scrollView;

- (id)initWithList:(PLList *)theList;

@end
