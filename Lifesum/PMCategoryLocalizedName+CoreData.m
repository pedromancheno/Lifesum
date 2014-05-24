//
//  PMCategoryLocalizedName+CoreData.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMCategoryLocalizedName+CoreData.h"

@implementation PMCategoryLocalizedName (CoreData)

+ (void)mapDictionary:(NSDictionary *)dictionary
             toObject:(PMCategoryLocalizedName *)localizedName
{
    NSString *key = dictionary.allKeys.firstObject;
    NSRange rangeOfName = [key rangeOfString:@"name_"];
    localizedName.code = [key substringFromIndex:rangeOfName.length];
    
    localizedName.name = dictionary[key];
}

@end
