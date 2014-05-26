//
//  NSManagedObject+PM.h
//  CoreDataHelper
//
//  Created by Pedro Mancheno on 5/23/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Helper)

+ (instancetype)createInContext:(NSManagedObjectContext *)context;

- (instancetype)inContext:(NSManagedObjectContext *)context;
- (instancetype)inMainContext;

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context;
+ (NSString *)entityName;

- (BOOL)destroy;
- (void)destroyInContext:(NSManagedObjectContext *)context;
- (BOOL)save;


/**
 * Find and return an existing object matching the info in a dictionary
 */
+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary
                                   inContext:(NSManagedObjectContext *)context;

/**
 * Return an object based on the information in the dictionary.
 * If no object is found, return a newly created object in the specified context
 * Note: The created object is not saved to the persistent store
 * This methods assumes you have implemented the - primaryKey and - dictionaryKey
 * class methods in your subclass
 */
+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary
                           inContext:(NSManagedObjectContext *)context;

+ (NSString *)primaryKey;
+ (NSString *)dictionaryKey;

@end

@interface NSManagedObject (Fetching)

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context
                    withError:(NSError **)pError;

+ (NSArray *)findAllIdsInContext:(NSManagedObjectContext *)context
                       withError:(NSError **)pError;

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError;

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
                         sortedBy:(NSString *)sortKey
                        ascending:(BOOL)ascending
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError;

+ (NSArray *)findAllWithContext:(NSManagedObjectContext *)context
                     whereField:(NSString *)fieldName
                         equals:(id)value
                      withError:(NSError **)pError;

+ (NSArray *)findAllWhereField:(NSString *)fieldName
                        equals:(id)value
                     inContext:(NSManagedObjectContext *)context
                     withError:(NSError **)pError;

+ (NSArray *)findAllWhereField:(NSString *)fieldName
                          isIn:(id<NSFastEnumeration>)collection
                     inContext:(NSManagedObjectContext *)context
                     withError:(NSError **)pError;

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
            andRetrieveAttributes:(NSArray *)attributes
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError;

+ (NSArray *)findAllAndRetrievedAttributes:(NSArray *)attributes
                                whereField:(NSString *)fieldName
                                    equals:(id)value
                                 inContext:(NSManagedObjectContext *)context
                                 withError:(NSError **)pError;

+ (NSArray *)findDistinctValuesOfAttribute:(NSString *)attribute
                             withPredicate:(NSPredicate *) predicate
                           sortedAscending:(BOOL)ascending
                                 inContext:(NSManagedObjectContext *)context
                                 withError:(NSError **)pError;

+ (instancetype)anyInCurrentContext;

+ (instancetype)anyInManagedObjectContext:(NSManagedObjectContext *)moc;

@end

@interface NSManagedObject (Requests)

+ (NSFetchRequest *) createFetchRequestInContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *) requestAllWithPredicate:(NSPredicate *)searchTerm
                                   inContext:(NSManagedObjectContext *)context;

@end

@interface NSManagedObject (Parsing)

+ (void)mapDictionary:(NSDictionary *)dictionary toObject:(id)object;

@end