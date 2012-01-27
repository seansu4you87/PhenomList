//
//  PLListDetailView.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLPhenomButton;

@interface PLListDetailView : UIScrollView
{
    UILabel *title_label;
    UILabel *summary_label;
    
    NSArray *phenom_buttons;
}

@property(nonatomic, assign) NSString *title;
@property(nonatomic, assign) NSString *summary;

- (PLPhenomButton *)buttonAtIndex:(NSInteger)index;

@end
