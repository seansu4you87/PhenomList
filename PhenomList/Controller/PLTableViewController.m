//
//  PLTableViewController.m
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLTableViewController.h"

@implementation PLTableViewController

@synthesize dataState = data_state;

#pragma mark - 
#pragma mark Static Methods

+ (UITableViewCell *)noResultsCell
{
    
}



#pragma mark - 
#pragma mark TableView Method Overrides

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (self.dataState)
    {
        case PLDataStateHasData:
            return [self numberOfDataSections];
            break;
        case PLDataStateNoResults:
            return [self numberOfNoResultsSections];
            break;
        case PLDataStateLoading:
            return [self numberOfLoadingSections];
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.dataState)
    {
        case PLDataStateHasData:
            return [self numberOfDataRowsInSection:section];
            break;
        case PLDataStateNoResults:
            return [self numberOfNoResultsRowsInSection:section];
            break;
        case PLDataStateLoading:
            return [self numberOfLoadingRowsInSection:section];
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.dataState)
    {
        case PLDataStateHasData:
            return [self dataCellForRowAtIndexPath:indexPath];
            break;
        case PLDataStateNoResults:
            return [self noResultsCellForRowAtIndexPath:indexPath];
            break;
        case PLDataStateLoading:
            return [self loadingCellForRowAtIndexPath:indexPath];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.dataState)
    {
        case PLDataStateHasData:
            [self didSelectDataRowAtIndexPath:indexPath];
            break;
        case PLDataStateNoResults:
            break;
        case PLDataStateLoading:
            break;
    }
}

#pragma mark - 
#pragma mark Has Data Methods

- (NSInteger)numberOfDataSections
{
    
}

- (NSInteger)numberOfDataRowsInSection:(NSInteger)section
{
    
}

- (UITableViewCell *)dataCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didSelectDataRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 
#pragma mark No Results Methods

- (NSInteger)numberOfNoResultsSections
{
    return 1;
}

- (NSInteger)numberOfNoResultsRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)noResultsCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didSelectNoResultsRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 
#pragma mark Loading Methods

- (NSInteger)numberOfLoadingSections
{
    
}

- (NSInteger)numberOfLoadingRowsInSection:(NSInteger)section
{
    
}

- (UITableViewCell *)loadingCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didSelectLoadingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
