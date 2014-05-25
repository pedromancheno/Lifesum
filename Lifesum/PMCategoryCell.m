//
//  PMCategoryCell.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMCategoryCell.h"

#import "PMCategory+CoreData.h"

@interface PMCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation PMCategoryCell

- (void)setObject:(PMCategory *)category
{
    self.nameLabel.text = category.name;
}

@end
