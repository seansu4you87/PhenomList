//
//  PLListsController.m
//  PhenomList
//
//  Created by Sean Yu on 12/23/11.
//  Copyright (c) 2011 Blackboard Mobile. All rights reserved.
//

#import "PLListsController.h"
#import "PLRequest.h"
#import "PLURL.h"
#import "PLListParser.h"
#import "PLList.h"
#import "PLLoadingView.h"

#import "PLArticleViewController.h"
#import "PLListCell.h"
#import "PLTableHeader.h"
#import "PLTableFooter.h"
#import <UIKit/UIKit.h>

@implementation PLListsController

- (id)init
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        self.title = @"PhenomList";
        
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PLLogo.png"]];
        
        PLRequest *request = [[PLRequest alloc] initWithURL:[PLURL listsURL] andParserClass:[PLListParser class]];
        [request performRequestWithSuccessBlock:^(id result){
            
            data = result;
            self.dataState = PLDataStateLoading;
            //self.tableView.scrollEnabled = YES;

            
        }andFailureBlock:^(NSError *error){
            
            self.dataState = PLDataStateNoResults;
            
        }];
        
        self.dataState = PLDataStateLoading;
        self.tableView.scrollEnabled = NO;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

-(void)viewDidLoad
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *tableHeader = [[PLTableHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 280)];
    
    UIView *tableFooter = [[PLTableFooter alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 280)];
    
    self.tableView.tableHeaderView = tableHeader;
    self.tableView.tableFooterView = tableFooter;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(-tableHeader.bounds.size.height, 0.0f, -tableFooter.bounds.size.height, 0.0f)];
    
}

- (UITableViewCell *)dataCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLList *list = [data objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [[PLListCell alloc] 
                             initWithLabel:list.title 
                             andImages:[NSArray arrayWithObjects: nil]];
    return cell;
}

- (CGFloat)heightForDataRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void)didSelectDataRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLArticleViewController *controller = [[PLArticleViewController alloc] init];
	
	//UINavigationController *test = self.navigationController;
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
    
    PLLoadingView *loadingView = [[PLLoadingView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    //loadingView.backgroundColor = [UIColor redColor];
    [cell addSubview:loadingView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
