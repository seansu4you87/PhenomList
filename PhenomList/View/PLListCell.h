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
    CGFloat image_width;
}

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle andImages:(NSArray *)imageArray;

@end
