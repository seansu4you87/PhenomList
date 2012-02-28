//
//  PLPhenomButton.h
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//



@interface PLPhenomButton : UIButton
{
    CGRect buttonFrame;
    
    NSURL *imageUrl;
    UIView *imageView;
    
    NSString *phenomName;
    UILabel *phenomLabel;
    
    NSString *agreeNumber;
    UILabel *numberLabel;
}
@property(nonatomic, assign) CGRect button_frame;

@property(nonatomic, retain) NSURL *image_url;
@property(nonatomic, retain) NSString *phenom_name;
@property(nonatomic, retain) NSString *agree_number;

@end
