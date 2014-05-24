
//
//  PMCategory+PM.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMCategory+CoreData.h"

#import "PMCategoryLocalizedName+CoreData.h"

@implementation PMCategory (CoreData)

+ (NSString *)dictionaryKey
{
    return @"oid";
}

+ (NSString *)primaryKey
{
    return @"categoryID";
}

+ (void)mapDictionary:(NSDictionary *)dictionary toObject:(PMCategory *)object
{
    object.categoryID = dictionary[@"oid"];
    object.name = dictionary[@"category"];
    object.headCategoryID = dictionary[@"headcategoryid"];
    object.servingsCategory = dictionary[@"servingscategory"];
    object.photoVersion = dictionary[@"photo_version"];

    
    NSTimeInterval lastUpdatedInterval = [dictionary[@"lastupdated"] doubleValue];
    object.lastUpdatedDate = [NSDate dateWithTimeIntervalSince1970:lastUpdatedInterval];
    
    // Parse localized names
    NSArray *localizedNames = [[dictionary allKeys] map:^id(NSString *key) {
        
        BOOL isName = [key rangeOfString:@"name_"].length > 0;
        BOOL isEmptyString = isName ? [dictionary[key] isEqualToString:@""] : NO;
        return isName && !isEmptyString ? @{ key : dictionary[key] } : nil;
    }];
    
    [self parseLocalizedNames:localizedNames toObject:object];
}

+ (void)parseLocalizedNames:(NSArray *)localizedNames
                   toObject:(PMCategory *)category
{
    
    NSManagedObjectContext *context = category.managedObjectContext;
    
    // Delete all previos localized names
    [category.localizedNames.allObjects each:^(PMCategoryLocalizedName *localizedName, NSUInteger index) {
        
        [context deleteObject:localizedName];
    }];
    
    [localizedNames each:^(NSDictionary *localizedNameDictionary, NSUInteger index) {
        
        PMCategoryLocalizedName *localizedName = [PMCategoryLocalizedName createInContext:context];
        [PMCategoryLocalizedName mapDictionary:localizedNameDictionary
                                      toObject:localizedName];
        
        [category addLocalizedNamesObject:localizedName];
    }];
}

@end
