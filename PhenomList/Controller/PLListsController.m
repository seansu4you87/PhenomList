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

#import "PLArticleViewController.h"
#import "PLListCell.h"
#import "PLTableHeader.h"
#import <UIKit/UIKit.h>

@implementation PLListsController

- (id)init
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        self.title = @"PhenomList";
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *tableHeader = [[PLTableHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 280)];
        self.tableView.tableHeaderView = tableHeader;
        [self.tableView setContentInset:UIEdgeInsetsMake(-tableHeader.bounds.size.height, 0.0f, 0.0f, 0.0f)];

        
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PLLogo.png"]];
        
        PLRequest *request = [[PLRequest alloc] initWithURL:[PLURL listsURL] andParserClass:[PLListParser class]];
        [request performRequestWithSuccessBlock:^(id result){
            
            data = result;
            self.dataState = PLDataStateHasData;
            
        }andFailureBlock:^(NSError *error){
            
            self.dataState = PLDataStateNoResults;
            
        }];
        
        self.dataState = PLDataStateLoading;
    }
    return self;
}

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
    
    //cell.textLabel.text = [NSString stringWithFormat:@"section %i, row %i", indexPath.section, indexPath.row];
    
    return cell;
}

/*
- (CGFloat)heightForDataRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}
*/

- (void)didSelectDataRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLArticleViewController *controller = [[PLArticleViewController alloc] init];
	
	//UINavigationController *test = self.navigationController;
	[self.navigationController pushViewController:controller animated:YES];
}

@end
