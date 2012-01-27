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

<<<<<<< HEAD
<<<<<<< HEAD
-(void)viewDidLoad
=======
=======
>>>>>>> merging origin/master into mergefuckup
- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *tableHeader = [[PLTableHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 280)];
    self.tableView.tableHeaderView = tableHeader;
    [self.tableView setContentInset:UIEdgeInsetsMake(-tableHeader.bounds.size.height, 0.0f, 0.0f, 0.0f)];
}

/*- (NSInteger)numberOfDataSections
<<<<<<< HEAD
>>>>>>> commit old work
=======
=======
-(void)viewDidLoad
>>>>>>> origin/master
>>>>>>> merging origin/master into mergefuckup
{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *tableHeader = [[PLTableHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 280)];
    
    UIView *tableFooter = [[PLTableFooter alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 280)];
    
    self.tableView.tableHeaderView = tableHeader;
    self.tableView.tableFooterView = tableFooter;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(-tableHeader.bounds.size.height, 0.0f, -tableFooter.bounds.size.height, 0.0f)];
    
}

#pragma mark - 
#pragma mark Data Stuff


/*- (NSInteger)numberOfDataSections
 {
 return 1;
 }
 
 - (NSInteger)numberOfDataRowsInSection:(NSInteger)section
 {
 return 1;
 }*/

- (UITableViewCell *)dataCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLList *list = [data objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [[PLListCell alloc] 
                             initWithLabel:list.title 
                             andImages:[NSArray arrayWithObjects: nil]];
    return cell;
}

<<<<<<< HEAD
<<<<<<< HEAD
/*
 - (CGFloat)heightForDataRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 66;
 }
*/
=======
=======
>>>>>>> merging origin/master into mergefuckup

- (CGFloat)heightForDataRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

<<<<<<< HEAD
>>>>>>> commit old work
=======
=======
/*
 - (CGFloat)heightForDataRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 66;
 }
*/
>>>>>>> origin/master
>>>>>>> merging origin/master into mergefuckup

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
