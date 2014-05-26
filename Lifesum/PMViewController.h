//
//  PMViewController.h
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface PMViewController : UIViewController
<NSFetchedResultsControllerDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (readonly, nonatomic) NSString *associatedEntityName;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
