//
//  PMAPIClient.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMAPIClient.h"

#import "AFNetworking.h"
#import "PMCoreDataHelper.h"
#import "PMCategory+CoreData.h"

#import <objc/runtime.h>

static NSString *const kBaseURL = @"https://dl.dropbox.com/s/";
static NSString *const kCategoriesPath = @"hiammhfnfbwxfo9/categoriesStatic.json";
static NSString *const kExercisesPath = @"b8jd0ome7svh6vl/exercisesStatic.json";
static NSString *const kFoodPath = @"tl6f4n3dw5v93p2/foodStatic.json";

typedef void(^PMParseCompletion)(NSArray *parsedObjects);

@implementation PMAPIClient

#pragma mark - Singleton

+ (instancetype)sharedClient
{
    static dispatch_once_t predicate = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&predicate, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark - API methods

- (void)categoriesWithCompletion:(PMAPIClientCompletion)clientCompletion
{
    [self sendRequestWithPath:kCategoriesPath
                   completion:^(BOOL success, NSArray *responseObjects, NSError *error) {
                       
                       if (success) {
                           [self parseObjects:responseObjects
                                      ofClass:[PMCategory class]
                                   completion:^(NSArray *parsedObjects) {
                                       
                                       if (clientCompletion)
                                           clientCompletion(success, parsedObjects, error);
                                   }];
                       } else {
                           
                           if (clientCompletion)
                               clientCompletion(success, nil, error);
                       }
                   }];
}

- (void)exercisesWithCompletion:(PMAPIClientCompletion)completion
{
    [self sendRequestWithPath:kExercisesPath completion:completion];
}

- (void)foodWithCompletion:(PMAPIClientCompletion)completion
{
    [self sendRequestWithPath:kFoodPath completion:completion];
}

#pragma mark - Request

- (void)sendRequestWithPath:(NSString *)path completion:(PMAPIClientCompletion)completion
{
    NSString *baseURLString = [NSString stringWithFormat:@"%@%@", kBaseURL, path];
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (completion) completion(YES, responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        if (completion) completion(NO, nil, error);
    }];
    
    [operation start];
}

#pragma mark - Parsing

- (void)parseObjects:(NSArray *)objects
                  ofClass:(Class)class
               completion:(PMParseCompletion)parseCompletion
{
     if (![class isSubclassOfClass:[NSManagedObject class]])
         return;
    
    __block NSArray *parsedObjects = nil;
    
    [[PMCoreDataHelper sharedInstance]
     performAndSaveInBackground:^(NSManagedObjectContext *context, NSError *__autoreleasing *pError) {
         
         parsedObjects = [objects map:^id(NSDictionary *dictionary) {
             id object = [class objectWithDictionary:dictionary inContext:context];
             [class mapDictionary:dictionary toObject:object];
             return object;
         }];
         
     } completion:^(BOOL success, NSError *error) {
         [parsedObjects each:^(NSManagedObject *object, NSUInteger index) {
             [object inMainContext];
         }];
         
         if (parseCompletion) parseCompletion(parsedObjects);
     }];
}

@end
