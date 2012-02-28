//
//  PLPhenomButton.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLPhenomButton.h"

#import "PLImageHelper.h"
#import "PLImageView.h"

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

-(UIButton *)makeAgreeButton
{
    UIButton *agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(-60, self.button_frame.size.width - 70, 50, 50)];
    agreeButton.backgroundColor = [UIColor orangeColor];
    
    UILabel *agreeText = [[UILabel alloc] initWithFrame:CGRectMake(0, (agreeButton.frame.size.height/3) * 2, agreeButton.frame.size.width, agreeButton.frame.size.height/3)];
    agreeText.text = @"AGREE";
    agreeText.textAlignment = UITextAlignmentCenter;
    agreeText.textColor = [UIColor whiteColor];
    
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, agreeButton.frame.size.width, (agreeButton.frame.size.height/3) * 2)];
    numberLabel.textAlignment = UITextAlignmentCenter;
    numberLabel.textColor = [UIColor whiteColor];

    [agreeButton addSubview:agreeText];
    [agreeButton addSubview:numberLabel];
    
    return agreeButton;
}

-(UIView *)makeBlackBar
{
    UIView *blackBar = [[UIView alloc] initWithFrame:CGRectMake(4, 4, self.button_frame.size.width - 8, self.button_frame.size.height - 8)];
    blackBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    
    phenomLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 4, blackBar.frame.size.width - 40, blackBar.frame.size.height)];
    phenomLabel.textColor = [UIColor whiteColor];
    phenomLabel.textAlignment = UITextAlignmentLeft;
    
    [blackBar addSubview:phenomLabel];
    
    //Make Agree Button
    [blackBar addSubview:[self makeAgreeButton]];

    return blackBar;
}


- (id)init
{
    if (self = [super init])
    {
        self.button_frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        [self setBackgroundImage:[PLImageHelper listCellSelectedImage] forState:UIControlStateNormal];
        
        //Make Base
        UIView *baseView = [self makeBaseView];
        
        //Make Image
        imageView = [[UIImageView alloc] initWithFrame:self.button_frame];
        [baseView addSubview:imageView];
        
        
        //Make BlackBar
        [baseView addSubview:[self makeBlackBar]];
    
        
        //Add Base to Self
        [self addSubview:baseView];
        
        
        //self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        //self.titleLabel.numberOfLines = 2;
    }
    return self;
}

-(void)setImage_url:(NSURL *)image_url
{
    imageView = [[PLImageView alloc] initWithImageUrl:image_url];
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







