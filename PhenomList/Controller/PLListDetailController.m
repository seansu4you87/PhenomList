//
//  PLListDetailController.m
//  PhenomList
//
//  Created by Sean Yu on 1/27/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "PLListDetailController.h"
#import "PLList.h"
#import "PLApplicationData.h"

@implementation PLListDetailController

- (id)initWithList:(PLList *)theList
{
    if (self = [super init])
    {
        list = theList;
        self.title = list.title;
        
        self.dataState = PLDataStateLoading;
        
        [[PLApplicationData singleton] getDetailForList:list successBlock:^(id result){
            
            data = list.phenoms;
            self.dataState = PLDataStateHasData;
            
        } andFailureBlock:^(NSError *error){
            
            self.dataState = PLDataStateNoResults;
            
        }];
    }
    return self;
}

- (UITableViewCell *)dataCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [[data objectAtIndex:indexPath.row] name];
    
    return cell;
}

@end
