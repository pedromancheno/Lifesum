//
//  PMExerciseCell.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/25/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMExerciseCell.h"

#import "PMExercise+CoreData.h"

@interface PMExerciseCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;

@end

@implementation PMExerciseCell

- (void)setObject:(PMExercise *)exercise
{
    self.nameLabel.text = exercise.name;
    self.caloriesLabel.text = exercise.calories.stringValue;
}

@end
