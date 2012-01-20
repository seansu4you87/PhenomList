//
//  PLListCellSelection.h
//  PhenomList
//
//  Created by Joe Taylor on 1/20/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLListCellSelection : UIView {
    CGSize shadow_size;
    CGFloat shadow_blur;
    UIColor *shadow_color;
}

- (id)initWithInnerShadowSize:(CGSize)shadowSize blur:(CGFloat)shadowBlur rect:(CGRect)rect andColor:(UIColor*)shadowColor;

@property (nonatomic, assign) CGSize shadowSize;
@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, retain) UIColor *shadowColor;

@end
