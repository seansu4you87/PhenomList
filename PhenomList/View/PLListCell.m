//
//  PLTableCell.m
//  PhenomList
//
//  Created by Joe Taylor on 1/17/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLListCell.h"
#import "PLListCellSelection.h"

@implementation PLListCell

@synthesize titleLabel = title_label;


- (id)initWithLabel:(NSString *)label andImages:(NSArray *)imageArray
{
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"])
	{
        
        image_width = 60;
        
        // Set Label
        self.titleLabel = label;
        self.textLabel.text = self.titleLabel;
        
        // Make Multiline
        self.textLabel.numberOfLines = 2;
        
        //Label Color
        self.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
        
        //Shadow
        self.textLabel.shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
        self.textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        
        // Make Font Smaller so it fits
        self.textLabel.font = [UIFont boldSystemFontOfSize: 16.0];

        // Custom BG
        self.textLabel.backgroundColor = [UIColor clearColor];        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PLTableCell.png"]];
        
        // Set selection color
        //UIView *myBackView = [[PLListCellSelection alloc] initWithInnerShadowSize:CGSizeMake(0.0f, 0.0f) blur:3 rect:CGRectMake(0, 0, 320, 66) andColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.1]];
        //myBackView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        //myBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.03];
        //self.selectedBackgroundView = myBackView;
        
        self.textLabel.highlightedTextColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
        
	}
	return self;
}

- (void)loadView
{
    
}

- (void)layoutSubviews 
{    
    [super layoutSubviews];
	
	// getting the cell size
    CGRect contentRect = self.contentView.bounds;
	
    if (!self.editing) {
		
		// get the X pixel spot
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
        
        /*
		 Place the title label.
		 place the label whatever the current X is plus 60 pixels from the left
		 center the text verticly
		 make the label 200 pixels wide
		 make the label 20 pixels high
         */
        
		frame = CGRectMake(boundsX + image_width, 0, self.frame.size.width - (image_width + 10), self.frame.size.height);
		self.textLabel.frame = frame;
	}
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animate
{
    UIColor * newShadow = highlighted ? [UIColor colorWithRed:0 green:0 blue:0 alpha:.1] : [UIColor whiteColor];
    
    
    self.textLabel.shadowColor = newShadow;
    
    [super setHighlighted:highlighted animated:animate];
}



@end
