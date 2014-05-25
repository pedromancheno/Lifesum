//
//  PMLocalizedName+CoreData.h
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMLocalizedName.h"

@protocol PMNameLocalizing <NSObject>

- (void)addLocalizedNamesObject:(PMLocalizedName *)value;
@property (nonatomic, retain) NSSet *localizedNames;

@end

@interface PMLocalizedName (CoreData)

+ (void)parseLocalizedNamesWithDictionary:(NSDictionary *)dictionary
                   toObject:(NSManagedObject<PMNameLocalizing> *)object;

@end
