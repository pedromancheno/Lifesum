//
//  PMExercise.h
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PMLocalizedName;

@interface PMExercise : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * isHidden;
@property (nonatomic, retain) NSNumber * isCustom;
@property (nonatomic, retain) NSNumber * isRemoved;
@property (nonatomic, retain) NSNumber * isDownloaded;
@property (nonatomic, retain) NSNumber * photoVersion;
@property (nonatomic, retain) NSNumber * exerciseID;
@property (nonatomic, retain) NSDate * lastUpdatedDate;
@property (nonatomic, retain) NSNumber * isAddedByUser;
@property (nonatomic, retain) NSNumber * calories;
@property (nonatomic, retain) NSSet *localizedNames;
@end

@interface PMExercise (CoreDataGeneratedAccessors)

- (void)addLocalizedNamesObject:(PMLocalizedName *)value;
- (void)removeLocalizedNamesObject:(PMLocalizedName *)value;
- (void)addLocalizedNames:(NSSet *)values;
- (void)removeLocalizedNames:(NSSet *)values;

@end
