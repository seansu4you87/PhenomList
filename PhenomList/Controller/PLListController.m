//
//  PLListsController.m
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLListController.h"
#import "PLListDetailController.h"

#import "PLApplicationData.h"
#import "PLList.h"

#import "NSDate+Formatting.h"

#import "PLLoadingView.h"
#import "PLListCell.h"
#import "PLTableHeader.h"
#import "PLTableFooter.h"
#import "PLLogo.h"

@interface PLListController (private)

- (PLList *)listForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation PLListController

- (id)init
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        self.title = @"PhenomList";
        
        self.navigationItem.titleView = [PLLogo logo];
        
        [[PLApplicationData singleton] getListsWithSuccessBlock:^(id result){
            
            data = result;
            self.dataState = PLDataStateHasData;
            self.tableView.scrollEnabled = YES;

            
        }andFailureBlock:^(NSError *error){
            
            self.dataState = PLDataStateNoResults;
            
        }];
        
        self.dataState = PLDataStateLoading;
        self.tableView.scrollEnabled = NO;
    }
    return self;
}

- (PLList *)listForIndexPath:(NSIndexPath *)indexPath
{
    PLList *list = [data objectAtIndex:indexPath.row];
    return list;
}

- (void)loadView
{
    [super loadView];
}

-(void)viewDidLoad
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *tableHeader = [PLTableHeader tableHeader];
    UIView *tableFooter = [PLTableFooter tableFooter];
    
    self.tableView.tableHeaderView = tableHeader;
    self.tableView.tableFooterView = tableFooter;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(-tableHeader.bounds.size.height, 0.0f, -tableFooter.bounds.size.height, 0.0f)];
}

- (UITableViewCell *)dataCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLList *list = [self listForIndexPath:indexPath];
    
    UITableViewCell *cell = [[PLListCell alloc] initWithTitle:list.title subtitle:[list.dateCreated timeAgoInWords] andImages:nil];
    return cell;
}

- (CGFloat)heightForDataRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)didSelectDataRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLList *list = [self listForIndexPath:indexPath];
    
    PLListDetailController *controller = [[PLListDetailController alloc] initWithList:list];
	
	[self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - 
#pragma mark Loading Stuff

-(CGFloat)heightForLoadingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.frame.size.height;
}

- (UITableViewCell *)loadingCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    
    PLLoadingView *loadingView = [[PLLoadingView alloc] init];
    [cell addSubview:loadingView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
