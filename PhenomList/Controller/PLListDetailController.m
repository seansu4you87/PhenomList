//
//  PLListDetailController.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLListDetailController.h"
#import "PLPhenomController.h"

#import "PLList.h"
#import "PLPhenom.h"
#import "PLApplicationData.h"

#import "PLListDetailView.h"
#import "PLPhenomButton.h"

@interface PLListDetailController (private)

- (void)setData;

@end

@implementation PLListDetailController

@dynamic scrollView;

- (id)initWithList:(PLList *)theList
{
    if (self = [super init])
    {
        list = theList;
        self.title = @"The Top";
        
        [[PLApplicationData singleton] getDetailForList:list successBlock:^(id result){
            
            [self setData];
            
        } andFailureBlock:^(NSError *error){
            
        }];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    detail_view = [[PLListDetailView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = detail_view;
    
    [self setData];
}

#pragma mark - 
#pragma mark Actions

- (void)phenomButtonPressed:(id)sender
{
    PLPhenom *phenom = [list phenomWithName:[[sender titleLabel] text]];
    
    [self.navigationController pushViewController:[[PLPhenomController alloc] initWithPhenom:phenom] animated:YES];
}

#pragma mark - 
#pragma mark Data Methods

- (void)setData
{
    detail_view.title = list.title;
    detail_view.summary = list.summary;
    
    for (int i = 0; i < [list.phenoms count]; i++)
    {
        PLPhenom *phenom = [list.phenoms objectAtIndex:i];
        PLPhenomButton *button = [detail_view buttonAtIndex:i];
        
        [button setTitle:phenom.name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(phenomButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 
#pragma mark Setters and Getters

- (UIScrollView *)scrollView
{
    return (UIScrollView *)self.view;
}

@end
