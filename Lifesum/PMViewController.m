//
//  PMViewController.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMViewController.h"

#import "PMCoreDataHelper.h"

@interface PMViewController ()

@end

@implementation PMViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fetchedResultsController.delegate = self;
}

#pragma mark - Lazy loading

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:self.associatedEntityName];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        fetchRequest.sortDescriptors = @[sortDescriptor];
        
        NSManagedObjectContext *context = [PMCoreDataHelper sharedInstance].managedObjectContext;
        _fetchedResultsController =
        [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                            managedObjectContext:context
                                              sectionNameKeyPath:nil
                                                       cacheName:nil];
        
        NSError *error;
        [_fetchedResultsController performFetch:&error];
    }
    
    return _fetchedResultsController;
}

#pragma mark - Abstract

- (NSString *)associatedEntityName
{
    // Override!
    return nil;
}

@end
