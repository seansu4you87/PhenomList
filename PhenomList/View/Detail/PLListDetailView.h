//
//  PLListDetailView.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLPhenomButton;
@class PLLargePhotoArrayView;

@interface PLListDetailView : UIScrollView
{
    UILabel *title_label;
    UILabel *summary_label;
    
    CGFloat image_width;
    
    NSArray *phenom_buttons;
    
    PLLargePhotoArrayView *photo_array_view;
}

@property(nonatomic, assign) NSString *title;
@property(nonatomic, assign) NSString *summary;

- (PLPhenomButton *)buttonAtIndex:(NSInteger)index;

- (void)setImageUrls:(NSArray *)imageUrls;

@end
