//
//  NSManagedObject+ObjectsManager.h
//
//  Created by spens on 28/07/15.
//  Copyright (c) 2015 spens. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ObjectsManager)

/*!
 * Creates new CoreData object with given values.
 * \returns NSManagedObject
 */
+ (instancetype)createItem;
/*!
 * Creates new CoreData object with given values.
 * You should provide NSDictionary with possible entity properties as keys.
 * \param
 * \returns NSManagedObject
 */
+ (instancetype)createItemWithValues:(NSDictionary *)values;
/*!
 * Delete object from DB
 *
 */
- (void)deleteItem;
/*!
 * Get object by dictionary
 * You should provide NSDictionary with possible entity properties as keys.
 * \param
 * \returns NSManagedObject
 */
+ (instancetype)itemWithValues:(NSDictionary *)values;
/*!
 * Get object with given values.
 * \returns NSManagedObject
 */
+ (instancetype)itemWithProperty:(NSString *)property value:(id)value;
/*!
 * Get all objects by array of predicates and sortDescriptors
 * \returns NSArray
 */
+ (NSArray *)fetchAllItemsWithPredicates:(NSArray *)predicates sortDescriptors:(NSArray *)sortDescriptors;
/*!
 * Check if CoreData object exists with given values.
 * \returns BOOL
 */
+ (BOOL)itemExistWithProperty:(NSString *)property value:(id)value;
/*!
 * Check if CoreData object exists with given values.
 * You should provide NSDictionary with entity properties as keys.
 * \returns BOOL
 */
+ (BOOL)itemExistWithValues:(NSDictionary *)values;
/*!
 * Save context
 */
+ (void)save;

+ (void)saveDataInContext:(void(^)(NSManagedObjectContext *context))block;

@end
