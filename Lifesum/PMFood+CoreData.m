//
//  PMFood+CoreData.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMFood+CoreData.h"

@implementation PMFood (CoreData)

+ (NSString *)dictionaryKey
{
    return @"oid";
}

+ (NSString *)primaryKey
{
    return @"foodID";
}

+ (void)mapDictionary:(NSDictionary *)dictionary toObject:(PMFood *)object
{
    // remove <null> from dictionary
    NSMutableDictionary *cleanDictionary = [dictionary mutableCopy];
    NSArray *keysForNullValues = [cleanDictionary allKeysForObject:[NSNull null]];
    [cleanDictionary removeObjectsForKeys:keysForNullValues];
    
    object.foodID = cleanDictionary[@"oid"];
    object.categoryID = cleanDictionary[@"categoryid"];
    object.sourceID = cleanDictionary[@"source_id"];
    object.name = cleanDictionary[@"title"];
    
    object.pcsInGram = cleanDictionary[@"pcsingram"];
    object.mlInGram = cleanDictionary[@"mlingram"];
    object.gramsPerServing = cleanDictionary[@"gramsperserving"];
    object.servingCategory = cleanDictionary[@"servingcategory"];
    object.brand = cleanDictionary[@"brand"];
    object.typeOfMeasurement = cleanDictionary[@"typeofmeasurement"];
    object.defaultSize = cleanDictionary[@"defaultsize"];
    
    object.language = cleanDictionary[@"language"];
    object.showMeasurement = cleanDictionary[@"showmeasurement"];
    object.pcsText = cleanDictionary[@"pcstext"];
    
    object.cholesterol = cleanDictionary[@"cholesterol"];
    object.sugar = cleanDictionary[@"sugar"];
    object.fiber = cleanDictionary[@"fiber"];
    object.fat = cleanDictionary[@"fat"];
    object.sodium = cleanDictionary[@"sodium"];
    object.calories = cleanDictionary[@"calories"];
    object.saturatedFat = cleanDictionary[@"saturatedfat"];
    object.potassium = cleanDictionary[@"potassium"];
    object.carbohydrates = cleanDictionary[@"carbohydrates"];
    object.protein = cleanDictionary[@"protein"];
    object.unsaturatedFat = cleanDictionary[@"unsaturatedfat"];
    
    NSTimeInterval lastUpdatedInterval = [cleanDictionary[@"lastupdated"] doubleValue];
    object.lastUpdatedDate = [NSDate dateWithTimeIntervalSince1970:lastUpdatedInterval];
    
    object.isAddedByUser = cleanDictionary[@"addedbyuser"];
    object.isRemoved = cleanDictionary[@"deleted"];
    object.isHidden = cleanDictionary[@"hidden"];
    object.isCustom = cleanDictionary[@"custom"];
    object.shouldShowSameTypeOnly = cleanDictionary[@"showonlysametype"];
}

- (BOOL)shouldMapDictionary:(NSDictionary *)dictionary
{
    if (self.lastUpdatedDate == nil) {
        return YES;
    }
    
    NSTimeInterval lastUpdatedInterval = [dictionary[@"lastupdated"] doubleValue];
    NSDate *lastUpdateDate = [NSDate dateWithTimeIntervalSince1970:lastUpdatedInterval];
    
    BOOL shouldMap = [self.lastUpdatedDate timeIntervalSinceDate:lastUpdateDate] != 0;
        
    return shouldMap;
}

@end
