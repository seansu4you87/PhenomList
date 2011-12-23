//
//  PLTableViewController.h
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLRequest.h"

@interface PLTableViewController : UITableViewController
{
    PLDataState     data_state;
}

@property(nonatomic, assign) PLDataState dataState;

#pragma mark - 
#pragma mark Has Data Methods

- (NSInteger)numberOfDataSections;
- (NSInteger)numberOfDataRowsInSection:(NSInteger)section;
- (UITableViewCell *)dataCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectDataRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 
#pragma mark No Results Methods

- (NSInteger)numberOfNoResultsSections;
- (NSInteger)numberOfNoResultsRowsInSection:(NSInteger)section;
- (UITableViewCell *)noResultsCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectNoResultsRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 
#pragma mark Loading Methods

- (NSInteger)numberOfLoadingSections;
- (NSInteger)numberOfLoadingRowsInSection:(NSInteger)section;
- (UITableViewCell *)loadingCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectLoadingRowAtIndexPath:(NSIndexPath *)indexPath;


@end
