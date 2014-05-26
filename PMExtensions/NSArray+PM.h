//
//  NSArray+PM.h
//  PMExtensions
//
//  Created by Pedro Mancheno on 9/5/13.
//  Copyright (c) 2013 Pedro Mancheno. All rights reserved.
//

@interface NSArray (PM)

/**
 * Returns the first object in an array or nil if array is empty.
 *
 * @return          First object in the array
 */
@property (nonatomic, readonly) id firstObject;


/**
 * Returns the last object in an array or nil if array is empty.
 *
 * @return          Last object in the array
 */
@property (nonatomic, readonly) id lastObject;


/**
 * Executes the block for each element in the array, passing the object and index as parameters.
 *
 * @param block     Block to be called for each element in the array
 */
- (void)each:(void (^)(id object, NSUInteger index))block;

/**
 * Executes the block for each element in the array, returning an array which contains the values
 * returned by the block.
 *
 * @param block     Block to be called for each element in the array
 *
 * @return          NSArray containing the values returned by the block
 */
- (NSArray *)map:(id (^)(id object))block;


/**
 * Executes the block for each element in the array, returning an array which contains the values
 * for which the block returns YES.
 *
 * @param block     Block to be called for each element in the array
 *
 * @return          NSArray containing the values for which the block returns YES
 */
- (NSArray *)select:(BOOL (^)(id object))block;

@end
