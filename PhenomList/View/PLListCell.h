//
//  PLTableCell.h
//  PhenomList
//
//  Created by Joe Taylor on 1/17/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLListCell : UITableViewCell    
{
    NSString *title_label;
    
    CGFloat image_width;
}


- (id)initWithLabel:(NSString *)label andImages:(NSArray *)imageArray;

@property (nonatomic, retain) NSString *titleLabel;

@end
