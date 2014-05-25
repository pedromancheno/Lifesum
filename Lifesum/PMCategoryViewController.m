//
//  PMCategoryViewController.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMCategoryViewController.h"

#import "PMCategory+CoreData.h"
#import "PMCoreDataHelper.h"
#import "PMCategoryCell.h"
#import "PMAPIClient.h"

@interface PMCategoryViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PMCategoryViewController

#pragma mark - UITableViewCell data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const CellIndentifier = @"PMCategoryCell";
    
    PMCategoryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (!cell) {
        cell = [[PMCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIndentifier];
    }
    
    PMCategory *category = self.fetchedResultsController.fetchedObjects[indexPath.row];
    [cell setObject:category];
    
    return cell;
}

#pragma mark - Overriden methods

- (NSString *)associatedEntityName
{
    return NSStringFromClass([PMCategory class]);
}

@end

