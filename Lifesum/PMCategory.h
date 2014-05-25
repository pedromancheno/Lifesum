//
//  PMCategory.h
//  Pods
//
//  Created by Pedro Mancheno on 5/24/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PMLocalizedName;

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

- (void)addLocalizedNamesObject:(PMLocalizedName *)value;
- (void)removeLocalizedNamesObject:(PMLocalizedName *)value;
- (void)addLocalizedNames:(NSSet *)values;
- (void)removeLocalizedNames:(NSSet *)values;

@end
