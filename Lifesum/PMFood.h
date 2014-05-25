//
//  PMFood.h
//  Pods
//
//  Created by Pedro Mancheno on 5/24/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PMFood : NSManagedObject

@property (nonatomic, retain) NSNumber * isDownloaded;
@property (nonatomic, retain) NSNumber * pcsInGram;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSNumber * sourceID;
@property (nonatomic, retain) NSNumber * showMeasurement;
@property (nonatomic, retain) NSNumber * cholesterol;
@property (nonatomic, retain) NSNumber * gramsPerServing;
@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSNumber * sugar;
@property (nonatomic, retain) NSNumber * fiber;
@property (nonatomic, retain) NSNumber * mlInGram;
@property (nonatomic, retain) NSString * pcsText;
@property (nonatomic, retain) NSDate * lastUpdatedDate;
@property (nonatomic, retain) NSNumber * isAddedByUser;
@property (nonatomic, retain) NSNumber * fat;
@property (nonatomic, retain) NSNumber * sodium;
@property (nonatomic, retain) NSNumber * isRemoved;
@property (nonatomic, retain) NSNumber * isHidden;
@property (nonatomic, retain) NSNumber * isCustom;
@property (nonatomic, retain) NSNumber * calories;
@property (nonatomic, retain) NSNumber * foodID;
@property (nonatomic, retain) NSNumber * servingCategory;
@property (nonatomic, retain) NSNumber * saturatedFat;
@property (nonatomic, retain) NSNumber * potassium;
@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSNumber * carbohydrates;
@property (nonatomic, retain) NSNumber * typeOfMeasurement;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * protein;
@property (nonatomic, retain) NSNumber * defaultSize;
@property (nonatomic, retain) NSNumber * shouldShowSameTypeOnly;
@property (nonatomic, retain) NSNumber * unsaturatedFat;

@end
