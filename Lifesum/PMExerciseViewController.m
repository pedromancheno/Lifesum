//
//  PMExerciseViewController.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMExerciseViewController.h"

#import "PMExercise+CoreData.h"
#import "PMCoreDataHelper.h"
#import "PMExerciseCell.h"
#import "PMAPIClient.h"


@interface PMExerciseViewController ()

@end

@implementation PMExerciseViewController

#pragma mark - UITableViewCell data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const CellIndentifier = @"PMExerciseCell";
    
    PMExerciseCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (!cell) {
        cell = [[PMExerciseCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIndentifier];
    }
    
    PMExercise *exercise = self.fetchedResultsController.fetchedObjects[indexPath.row];
    [cell setObject:exercise];
    
    return cell;
}

#pragma mark - Overriden methods

- (NSString *)associatedEntityName
{
    return NSStringFromClass([PMExercise class]);
}


@end
