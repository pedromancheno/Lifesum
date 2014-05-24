//
//  PMExercise+CoreData.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMExercise+CoreData.h"

#import "PMLocalizedName+CoreData.h"

@interface PMExercise () <PMNameLocalizing>

@end

@implementation PMExercise (CoreData)

+ (NSString *)dictionaryKey
{
    return @"oid";
}

+ (NSString *)primaryKey
{
    return @"exerciseID";
}

+ (void)mapDictionary:(NSDictionary *)dictionary toObject:(PMExercise *)object
{
    object.exerciseID = dictionary[@"oid"];
    object.isAddedByUser = dictionary[@"addedbyuser"];
    object.calories = dictionary[@"calories"];
    object.isCustom = dictionary[@"custom"];
    object.isRemoved = dictionary[@"deleted"];
    object.isDownloaded = dictionary[@"downloaded"];
    object.isHidden = dictionary[@"hidden"];
    object.photoVersion = dictionary[@"photo_version"];
    object.name = dictionary[@"title"];
    
    NSTimeInterval lastUpdatedInterval = [dictionary[@"lastupdated"] doubleValue];
    object.lastUpdatedDate = [NSDate dateWithTimeIntervalSince1970:lastUpdatedInterval];
    
    [PMLocalizedName parseLocalizedNamesWithDictionary:dictionary
                                              toObject:object];
}

@end
