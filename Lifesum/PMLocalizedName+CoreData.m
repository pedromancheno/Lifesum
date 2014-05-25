//
//  PMLocalizedName+CoreData.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMLocalizedName+CoreData.h"

@implementation PMLocalizedName (CoreData)

+ (void)mapDictionary:(NSDictionary *)dictionary
             toObject:(PMLocalizedName *)localizedName
{
    NSString *key = dictionary.allKeys.firstObject;
    NSRange rangeOfName = [key rangeOfString:@"name_"];
    localizedName.code = [key substringFromIndex:rangeOfName.length];
    
    localizedName.name = dictionary[key];
}

+ (void)parseLocalizedNamesWithDictionary:(NSDictionary *)dictionary
                                 toObject:(NSManagedObject<PMNameLocalizing> *)object
{
    NSManagedObjectContext *context = object.managedObjectContext;
 
    // Parse localized names
    NSArray *localizedNames = [[dictionary allKeys] map:^id(NSString *key) {
        
        BOOL isName = [key rangeOfString:@"name_"].length > 0;
        BOOL isEmptyString = isName ? [dictionary[key] isEqualToString:@""] : NO;
        return isName && !isEmptyString ? @{ key : dictionary[key] } : nil;
    }];
    
    // Delete all previos localized names
    [object.localizedNames.allObjects each:^(PMLocalizedName *localizedName, NSUInteger index) {
        
        [context deleteObject:localizedName];
    }];
    
    [localizedNames each:^(NSDictionary *localizedNameDictionary, NSUInteger index) {
        
        PMLocalizedName *localizedName = [PMLocalizedName createInContext:context];
        [PMLocalizedName mapDictionary:localizedNameDictionary
                                      toObject:localizedName];
        
        [object addLocalizedNamesObject:localizedName];
    }];
}

@end
