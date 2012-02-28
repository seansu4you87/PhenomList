//
//  PLPhenomButton.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLPhenomButton.h"

#import "PLImageHelper.h"

@implementation PLPhenomButton

@synthesize button_frame = buttonFrame;

@synthesize image_url = imageUrl;
@synthesize phenom_name = phenomName;
@synthesize agree_number = agreeNumber;

-(UIView *)makeBaseView
{
    UIView *baseView = [[UIView alloc] initWithFrame:self.button_frame];
    baseView.backgroundColor = [UIColor whiteColor];
    //Add shadow

    return baseView;
}


- (id)init
{
    if (self = [super init])
    {
        //This is erroring, why?
        //self.button_frame = [CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        [self setBackgroundImage:[PLImageHelper listCellSelectedImage] forState:UIControlStateNormal];
        
        //Make Base
        UIView *baseView = [self makeBaseView];
        
        //Make Image
        imageView = [[UIImageView alloc] init];
        [baseView addSubview:imageView];
        
        
        //Make BlackBar
        UIView *blackBar = [[UIView alloc] initWithFrame:self.button_frame];
        blackBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        
        phenomLabel = [[UILabel alloc] initWithFrame:self.button_frame];
        [blackBar addSubview:phenomLabel];
        [baseView addSubview:blackBar];
        
        
        //Make Agree Button
        UIButton *agreeButton = [[UIButton alloc] initWithFrame:self.button_frame];
        UILabel *agreeText = [[UILabel alloc] initWithFrame:self.button_frame];
        agreeText.text = @"AGREE";
        agreeText.textAlignment = UITextAlignmentCenter;
        agreeText.textColor = [UIColor whiteColor];
        
        numberLabel = [[UILabel alloc] initWithFrame:self.button_frame];
        [agreeButton addSubview:agreeText];
        [agreeButton addSubview:numberLabel];
        
        [baseView addSubview:agreeButton];
        
        
        //Add Base to Self
        [self addSubview:baseView];
        
        
        //self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        //self.titleLabel.numberOfLines = 2;
    }
    return self;
}

-(void)setImage_url:(NSString *)image_url
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:image_url]];
    UIImage *image = [[UIImage alloc] initWithData:imageData];

    [self.imageView setImage:image];
}

-(void)setPhenom_name:(NSString *)phenom_name
{
    phenomLabel.text = phenom_name;
}

-(void)setAgree_number:(NSString *)agree_number
{
    numberLabel.text = agreeNumber;
}

@end







