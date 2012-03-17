//
//  PLListDetailView.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLListDetailView.h"
#import "PLPhenomButton.h"
#import "PLTableHeader.h"
#import "PLTableFooter.h"

#import "PLLargePhotoArrayView.h"

#import "PLImageHelper.h"
#import "PLLabelHelper.h"

@interface PLListDetailView (private)

- (void)createPhenomButtons;

@end

@implementation PLListDetailView
{
    UIView *header;
    UIView *footer;
}

@dynamic title, summary;

-(void)initTextStyle
{
    title_label = [[UILabel alloc] initWithFrame:CGRectZero];
    title_label.backgroundColor = [UIColor clearColor];
    title_label.numberOfLines = 2;
    title_label.font = [UIFont boldSystemFontOfSize:20];
    title_label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
    title_label.shadowColor = [UIColor whiteColor];
    title_label.shadowOffset = CGSizeMake(0, 1);

    summary_label = [[UILabel alloc] initWithFrame:CGRectZero];
    summary_label.backgroundColor = [UIColor clearColor];
    summary_label.numberOfLines = 0;
    summary_label.font = [UIFont systemFontOfSize:16];
    summary_label.textColor = [UIColor darkTextColor];
    summary_label.shadowColor = [UIColor whiteColor];
    summary_label.shadowOffset = CGSizeMake(0, 1);
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[PLImageHelper tableFooterImage]];
        self.alwaysBounceVertical = YES;
        
        header = [PLTableHeader tableHeader];
        [self addSubview:header];
        
        footer = [PLTableFooter tableFooter];
        [self addSubview:footer];
        
        [self setContentInset:UIEdgeInsetsMake(-header.bounds.size.height, 0.0f, -footer.bounds.size.height, 0.0f)];
        
        image_width = 90;

        [self initTextStyle];
        
        [self addSubview:title_label];
        [self addSubview:summary_label];
        
        photo_array_view = [[PLLargePhotoArrayView alloc] initWithURLs:[NSArray arrayWithObjects:@"test", @"test", @"test", @"test", @"test", nil]];

        [self addSubview:photo_array_view];

        [self createPhenomButtons];
    }
    return self;
}

- (PLPhenomButton *)buttonAtIndex:(NSInteger)index
{
    if ([phenom_buttons count] > index)
        return [phenom_buttons objectAtIndex:index];
    
    return nil;
}

- (void)createPhenomButtons
{
    NSMutableArray *muta = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++)
    {
        PLPhenomButton *button = [[PLPhenomButton alloc] init];
        [self addSubview:button];
        
        [muta addObject:button];
    }
    
    phenom_buttons = [NSArray arrayWithArray:muta];
}


- (void)layoutSubviews
{
    CGFloat x_margin = 10;
    CGFloat y_margin = 10;
    CGFloat button_y_margin = 30;
    CGFloat width = self.bounds.size.width - 2 * x_margin;
    
    //CGSize titleSize = [PLLabelHelper sizeForTextInLabel:title_label withMaxSize:CGSizeMake(width, self.bounds.size.height)];
    title_label.frame = CGRectMake(x_margin + image_width + 15, CGRectGetMaxY(header.frame) + y_margin, self.frame.size.width - (x_margin + image_width + 15), 90);
    
    photo_array_view.frame = CGRectMake(x_margin, CGRectGetMaxX(header.frame)-20, 80, 80);    
    
    CGSize summarySize = [PLLabelHelper sizeForTextInLabel:summary_label withMaxSize:CGSizeMake(width, self.bounds.size.height)];
    summary_label.frame = CGRectMake(x_margin, CGRectGetMaxY(title_label.frame) + y_margin + 10, summarySize.width, summarySize.height);
    
    
    CGFloat button_width = self.bounds.size.width - (x_margin * 2);
    CGFloat button_height = 120;
    CGFloat previous_y = CGRectGetMaxY(summary_label.frame) + y_margin;
    
    
    for (int i = 0; i < 4; i++)
    {
        if(i > 0)
        {
            previous_y = previous_y + button_height + button_y_margin;
        }else   {
            previous_y = previous_y + button_y_margin;
        }
        
        PLPhenomButton *button = [phenom_buttons objectAtIndex:i];
        button.frame = CGRectMake(x_margin, previous_y, button_width, button_height);
        
        footer.frame = CGRectMake(footer.frame.origin.x, CGRectGetMaxY(button.frame) + y_margin, footer.frame.size.width, footer.frame.size.height);
    }    

    self.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(footer.frame) + y_margin);
}

#pragma mark - 
#pragma mark Setters and Getters

- (void)setImageUrls:(NSMutableArray *)imageUrls
{
    photo_array_view.imageUrls = imageUrls;
}

- (NSString *)title
{
    return title_label.text;
}

- (void)setTitle:(NSString *)theTitle
{
    title_label.text = theTitle;
}

- (NSString *)summary
{
    return summary_label.text;
}

- (void)setSummary:(NSString *)theSummary
{
    summary_label.text = theSummary;
}

@end
