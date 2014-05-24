//
//  PMAPIClient.h
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

typedef void(^PMAPIClientCompletion)(BOOL success, NSArray *responseObjects, NSError *error);

@interface PMAPIClient : NSObject

+ (instancetype)sharedClient;

- (void)categoriesWithCompletion:(PMAPIClientCompletion)completion;
- (void)exercisesWithCompletion:(PMAPIClientCompletion)completion;
- (void)foodWithCompletion:(PMAPIClientCompletion)completion;

@end
