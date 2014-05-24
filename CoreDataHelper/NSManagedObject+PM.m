//
//  NSManagedObject+PM.m
//  CoreDataHelper
//
//  Created by Pedro Mancheno on 5/23/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "NSManagedObject+PM.h"

#import "PMCoreDataHelper.h"

@implementation NSManagedObject (Helper)

+ (instancetype)createInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

- (instancetype)inContext:(NSManagedObjectContext *)context
{
    if (context == self.managedObjectContext)
        return self;
    
    return [context objectWithID:self.objectID];
}

- (instancetype)inMainContext
{
    return [self inContext:[PMCoreDataHelper sharedInstance].managedObjectContext];
}

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+ (NSString *)entityName
{
    return NSStringFromClass(self);
}

- (BOOL)destroy
{
    [[PMCoreDataHelper sharedInstance].managedObjectContext deleteObject:self];
    if ([self save]) {
        return YES;
    }
    NSLog(@"Error deleting object: %@", self);
    return NO;
}

- (void)destroyInContext:(NSManagedObjectContext *)context
{
    [context deleteObject:self];
}

- (BOOL)save
{
    return [[PMCoreDataHelper sharedInstance].managedObjectContext save:0];
}

+ (instancetype)existingObjectWithDictionary:(NSDictionary *)dictionary
                                   inContext:(NSManagedObjectContext *)context
{
    id lookupObject = dictionary[[self dictionaryKey]];
    if ([lookupObject isKindOfClass:[NSString class]]) {
        lookupObject = @([lookupObject integerValue]);
    }
    
    NSArray* objects = [self findAllWhereField:[self primaryKey]
                                        equals:lookupObject
                                     inContext:context withError:nil];
    
    return [objects count] > 0 ? objects[0] : nil;
}

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary
                           inContext:(NSManagedObjectContext *)context
{
    NSManagedObject *obj = [self existingObjectWithDictionary:dictionary
                                                    inContext:context];
    if (!obj) {
        obj = [self createInContext:context];
    }
    return obj;
}

+ (NSString *)primaryKey
{
    // implement in subclass
    return nil;
}

+ (NSString *)dictionaryKey
{
    // implement in subclass
    return nil;
}

@end

@implementation NSManagedObject (Fetching)

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context
                    withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self createFetchRequestInContext:context];
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllIdsInContext:(NSManagedObjectContext *)context
                       withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self createFetchRequestInContext:context];
    [fetchRequest setIncludesPropertyValues:NO];
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self requestAllWithPredicate:predicate inContext:context];
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
                         sortedBy:(NSString *)sortKey
                        ascending:(BOOL)ascending
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self requestAllWithPredicate:predicate inContext:context];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:ascending]];
    
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllWithContext:(NSManagedObjectContext *)context
                     whereField:(NSString *)fieldName
                         equals:(id)value
                      withError:(NSError **)pError
{
    return [self findAllWhereField:fieldName equals:value inContext:context withError:pError];
}
+ (NSArray *)findAllWhereField:(NSString *)fieldName
                        equals:(id)value
                     inContext:(NSManagedObjectContext *)context
                     withError:(NSError **)pError;
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K == %@", fieldName, value];
    return [self findAllWithPredicate:predicate inContext:context withError:pError];
}

+ (NSArray *)findAllWhereField:(NSString *)fieldName
                          isIn:(id<NSFastEnumeration>)collection
                     inContext:(NSManagedObjectContext *)context
                     withError:(NSError **)pError
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K IN %@", fieldName, collection];
    return [self findAllWithPredicate:predicate inContext:context withError:pError];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
            andRetrieveAttributes:(NSArray *)attributes
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self requestAllWithPredicate:predicate inContext:context ];
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPropertiesToFetch:attributes];
    [fetchRequest setPredicate:predicate];
    
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllAndRetrievedAttributes:(NSArray *)attributes
                                whereField:(NSString *)fieldName
                                    equals:(id)value
                                 inContext:(NSManagedObjectContext *)context
                                 withError:(NSError **)pError {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K == %@", fieldName, value];
    return [self findAllWithPredicate:predicate andRetrieveAttributes:attributes inContext:context withError:pError];
}

+ (NSArray *)findDistinctValuesOfAttribute:(NSString *)attribute
                             withPredicate:(NSPredicate *) predicate
                           sortedAscending:(BOOL)ascending
                                 inContext:(NSManagedObjectContext *)context
                                 withError:(NSError **)pError
{
    // create the fetch request and set the attributes of the request based on the given parameters
    NSFetchRequest* fetchRequest = [self requestAllWithPredicate:predicate inContext:context ];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute
                                                                   ascending:ascending];
    
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPropertiesToFetch:@[attribute]];
    [fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // execute the fetch, result is returned in an array of dictionaries
    NSArray * attributeArray = [context executeFetchRequest:fetchRequest error:pError];
    
    return [attributeArray valueForKey:attribute];
}

+ (instancetype)anyInCurrentContext
{
    return [self anyInManagedObjectContext:[[PMCoreDataHelper sharedInstance] managedObjectContext]];
}

+ (instancetype)anyInManagedObjectContext:(NSManagedObjectContext *)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[[self class] description] inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    
    if ([results count]) {
        return results[0];
    }
    else {
        return nil;
    }
}

@end

@implementation NSManagedObject (Requests)

+ (NSFetchRequest *)createFetchRequestInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[self entityDescriptionInContext:context]];
    
    return request;
}

+ (NSFetchRequest *) requestAllWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context;
{
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    
    if (searchTerm)
        [request setPredicate:searchTerm];
    
    return request;
}

@end

@implementation NSManagedObject (Parsing)

+ (void)mapDictionary:(NSDictionary *)dictionary toObject:(id)object
{
    // abstract
}

@end