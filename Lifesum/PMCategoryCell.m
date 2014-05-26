//
//  PMCategoryCell.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMCategoryCell.h"

#import "PMCategory+CoreData.h"
#import "TTTTimeIntervalFormatter.h"

@interface PMCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@property (strong, nonatomic) TTTTimeIntervalFormatter *timeIntervalFormatter;

@end

@implementation PMCategoryCell

- (void)setObject:(PMCategory *)category
{
    self.nameLabel.text = category.name;
    self.lastUpdatedLabel.text =
    [self.timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date]
                                                       toDate:category.lastUpdatedDate];
}

- (TTTTimeIntervalFormatter *)timeIntervalFormatter
{
    if (!_timeIntervalFormatter) {
        _timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    }
    
    return _timeIntervalFormatter;
}




@end
