//
//  PMFoodViewController.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMFoodViewController.h"

#import "PMFood+CoreData.h"
#import "PMFoodCell.h"

@interface PMFoodViewController ()

@end

@implementation PMFoodViewController

#pragma mark - UITableViewCell data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const CellIndentifier = @"PMFoodCell";
    
    PMFoodCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (!cell) {
        cell = [[PMFoodCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIndentifier];
    }
    
    PMFood *food = self.fetchedResultsController.fetchedObjects[indexPath.row];
    [cell setObject:food];
    
    return cell;
}

#pragma mark - Overriden methods

- (NSString *)associatedEntityName
{
    return NSStringFromClass([PMFood class]);
}

@end
