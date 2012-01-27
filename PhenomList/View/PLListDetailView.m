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

        title_label = [[UILabel alloc] initWithFrame:CGRectZero];
        title_label.backgroundColor = [UIColor clearColor];
        title_label.numberOfLines = 2;
        title_label.font = [UIFont boldSystemFontOfSize:24];
        title_label.textColor = [UIColor darkTextColor];
        title_label.shadowColor = [UIColor whiteColor];
        title_label.shadowOffset = CGSizeMake(0, 0.5);
        
        [self addSubview:title_label];
        
        summary_label = [[UILabel alloc] initWithFrame:CGRectZero];
        summary_label.backgroundColor = [UIColor clearColor];
        summary_label.numberOfLines = 0;
        summary_label.font = [UIFont systemFontOfSize:12];
        summary_label.textColor = [UIColor darkTextColor];
        summary_label.shadowColor = [UIColor whiteColor];
        summary_label.shadowOffset = CGSizeMake(0, 0.5);
        
        [self addSubview:summary_label];
        
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
    CGFloat width = self.bounds.size.width - 2 * x_margin;
    
    CGSize titleSize = [PLLabelHelper sizeForTextInLabel:title_label withMaxSize:CGSizeMake(width, self.bounds.size.height)];
    title_label.frame = CGRectMake(x_margin, CGRectGetMaxY(header.frame) + y_margin, titleSize.width, titleSize.height);
    
    CGSize summarySize = [PLLabelHelper sizeForTextInLabel:summary_label withMaxSize:CGSizeMake(width, self.bounds.size.height)];
    summary_label.frame = CGRectMake(x_margin, CGRectGetMaxY(title_label.frame) + y_margin, summarySize.width, summarySize.height);
    
    
    CGFloat button_width = (self.bounds.size.width - 3 * x_margin) / 2;
    CGFloat button_height = 66;
    CGFloat previous_y = CGRectGetMaxY(summary_label.frame) + y_margin;
    
    PLPhenomButton *button0 = [phenom_buttons objectAtIndex:0];
    button0.frame = CGRectMake(x_margin, previous_y, button_width, button_height);
    
    PLPhenomButton *button1 = [phenom_buttons objectAtIndex:1];
    button1.frame = CGRectMake(2 * x_margin + button_width, previous_y, button_width, button_height);
    
    previous_y = CGRectGetMaxY(button0.frame) + y_margin;
    
    PLPhenomButton *button2 = [phenom_buttons objectAtIndex:2];
    button2.frame = CGRectMake( (self.bounds.size.width - button_width) / 2, previous_y, button_width, button_height);
    
    previous_y = CGRectGetMaxY(button2.frame) + y_margin;
    
    PLPhenomButton *button3 = [phenom_buttons objectAtIndex:3];
    button3.frame = CGRectMake(x_margin, previous_y, button_width, button_height);
    
    PLPhenomButton *button4 = [phenom_buttons objectAtIndex:4];
    button4.frame = CGRectMake(2 * x_margin + button_width, previous_y, button_width, button_height);
    
    footer.frame = CGRectMake(footer.frame.origin.x, CGRectGetMaxY(button4.frame) + y_margin, footer.frame.size.width, footer.frame.size.height);
    self.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(footer.frame) + y_margin);
}

#pragma mark - 
#pragma mark Setters and Getters

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
