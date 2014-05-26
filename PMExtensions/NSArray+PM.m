//
//  NSArray+PM.m
//  PMExtensions
//
//  Created by Pedro Mancheno on 9/5/13.
//  Copyright (c) 2013 Pedro Mancheno. All rights reserved.
//

#import "NSArray+PM.h"

@implementation NSArray (PM)

- (id)firstObject
{
    return self.count > 0 ? self[0] : nil;
}

- (id)lastObject
{
    return self.count > 0 ? self[self.count - 1] : nil;
}

- (void)each:(void (^)(id object, NSUInteger index))block
{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (NSArray *)map:(id (^)(id object))block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self each:^(id object, NSUInteger index) {
        id newObject = block ? block(object) : object;
        if (newObject)
            [array addObject:newObject];
    }];
    return array;
}

- (NSArray *)select:(BOOL (^)(id object))block
{
    return [self map:^id(id object) {
        return block(object) ? object : nil;
    }];
}

@end
