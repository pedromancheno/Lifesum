//
//  PMFoodCell.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMFoodCell.h"

#import "PMFood+CoreData.h"

@interface PMFoodCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *proteinLabel;
@property (weak, nonatomic) IBOutlet UILabel *sodiumLabel;

@end

@implementation PMFoodCell

- (void)setObject:(PMFood *)food
{
    self.nameLabel.text = food.name;
    self.caloriesLabel.text = [NSString stringWithFormat:NSLocalizedString(@"calories: %@", nil), food.calories.stringValue];
    self.proteinLabel.text = [NSString stringWithFormat:NSLocalizedString(@"protein: %@", nil), food.protein.stringValue];
    self.sodiumLabel.text = [NSString stringWithFormat:NSLocalizedString(@"sodium: %@", nil), food.sodium.stringValue];
}

@end
