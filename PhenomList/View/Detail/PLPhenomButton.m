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
    agreeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    agreeButton.backgroundColor = [UIColor colorWithRed:245/256.0 green:60/256.0 blue:0 alpha:1];
    
    UILabel *agreeText = [[UILabel alloc] initWithFrame:CGRectMake(0,25,50,25)];
    agreeText.text = @"AGREE";
    agreeText.textAlignment = UITextAlignmentCenter;
    agreeText.textColor = [UIColor whiteColor];
    agreeText.backgroundColor = [UIColor clearColor];
    agreeText.font = [UIFont systemFontOfSize:11];
    
    
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(4,0,42,35)];
    numberLabel.textAlignment = UITextAlignmentCenter;
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.font = [UIFont boldSystemFontOfSize:20];
    numberLabel.adjustsFontSizeToFitWidth = YES;
    numberLabel.text = @"20000";


    [agreeButton addSubview:agreeText];
    [agreeButton addSubview:numberLabel];
    
    return agreeButton;
}

-(UIView *)makeBlackBar
{
    blackBar = [[UIView alloc] initWithFrame:CGRectZero];
    blackBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    
    phenomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    phenomLabel.textColor = [UIColor whiteColor];
    phenomLabel.backgroundColor = [UIColor clearColor];
    phenomLabel.textAlignment = UITextAlignmentLeft;
    phenomLabel.font = [UIFont boldSystemFontOfSize:14];
    
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
        self.backgroundColor = [UIColor whiteColor];
        
        //TODO: Check if this matters, it's erroring from changing Super Class from UIButton to UIView
        //[self setBackgroundImage:[PLImageHelper listCellSelectedImage] forState:UIControlStateNormal];
        
        //Make Base
        UIView *baseView = [self makeBaseView];
        
        //Make Image
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];

        //Add test image
        imageView.image = [UIImage imageNamed:@"test_pic.png"];

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    phenomLabel.frame = (CGRect){10, 0, self.frame.size.width, 32};
    blackBar.frame = (CGRect){0, 0, self.frame.size.width, 32};
    agreeButton.frame = (CGRect){blackBar.frame.size.width - 60, -11, 50, 50};
    imageView.frame = (CGRect){2, 2, self.frame.size.width - 4, self.frame.size.height - 4};
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







