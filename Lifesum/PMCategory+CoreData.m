
//
//  PMCategory+PM.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMCategory+CoreData.h"

#import "PMLocalizedName+CoreData.h"

@interface PMCategory () <PMNameLocalizing>

@end

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
    
    [PMLocalizedName parseLocalizedNamesWithDictionary:dictionary
                                              toObject:object];
}

@end
