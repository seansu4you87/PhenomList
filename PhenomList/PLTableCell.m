//
//  PLTableCell.m
//  PhenomList
//
//  Created by Joe Taylor on 1/17/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLTableCell.h"

@implementation PLTableCell

@synthesize titleLabel = title_label;


- (id)initWithLabel:(NSString *)label andImages:(NSArray *)imageArray
{
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"])
	{
        // Set Label
        self.titleLabel = label;
        self.textLabel.text = self.titleLabel;
        
        // Make Multiline
        self.textLabel.numberOfLines = 2;
        
        // Make Font Smaller so it fits
        self.textLabel.font = [UIFont boldSystemFontOfSize: 16.0];

        // Custom BG
        self.textLabel.backgroundColor = [UIColor clearColor];        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PLTableCell.png"]];
        
        // Set selection color
        UIView *myBackView = [[UIView alloc] initWithFrame:self.frame];
        myBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.1];
        self.selectedBackgroundView = myBackView;
        self.textLabel.highlightedTextColor = [UIColor blackColor];

        
	}
	return self;
}

- (void)loadView
{
    
}


- (void)layoutSubviews {
    
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
		frame = CGRectMake(boundsX + 60, 0, self.frame.size.width - 70, self.frame.size.height);
		self.textLabel.frame = frame;
        
		
	}
}


@end
