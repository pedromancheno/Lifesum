//
//  PMAPIClient.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMAPIClient.h"

#import "AFNetworking.h"

static NSString *const kBaseURL = @"https://dl.dropbox.com/s/";
static NSString *const kCategoriesPath = @"hiammhfnfbwxfo9/categoriesStatic.json";
static NSString *const kExercisesPath = @"b8jd0ome7svh6vl/exercisesStatic.json";
static NSString *const kFoodPath = @"tl6f4n3dw5v93p2/foodStatic.json";

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

- (void)categoriesWithCompletion:(PMAPIClientCompletion)completion
{
    [self sendRequestWithPath:kCategoriesPath completion:completion];
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

@end
