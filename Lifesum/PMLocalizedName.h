//
//  PMLocalizedName.h
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PMCategory, PMExercise;

@interface PMLocalizedName : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) PMCategory *category;
@property (nonatomic, retain) PMExercise *exercise;

@end
