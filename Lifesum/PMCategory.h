//
//  PMCategory.h
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PMCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * headCategoryID;
@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSNumber * servingsCategory;
@property (nonatomic, retain) NSNumber * photoVersion;
@property (nonatomic, retain) NSDate * lastUpdatedDate;
@property (nonatomic, retain) NSSet *localizedNames;
@end

@interface PMCategory (CoreDataGeneratedAccessors)

- (void)addLocalizedNamesObject:(NSManagedObject *)value;
- (void)removeLocalizedNamesObject:(NSManagedObject *)value;
- (void)addLocalizedNames:(NSSet *)values;
- (void)removeLocalizedNames:(NSSet *)values;

@end
