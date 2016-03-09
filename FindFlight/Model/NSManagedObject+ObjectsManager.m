//
//  NSManagedObject+ObjectsManager.m
//
//  Created by spens on 28/07/15.
//  Copyright (c) 2015 spens. All rights reserved.
//

#import "NSManagedObject+ObjectsManager.h"
#import "objc/runtime.h"
#import <objc/message.h>
#import "AppDelegate.h"

#define string(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]

@implementation NSManagedObject (ObjectsManager)

+ (instancetype)createItem
{
    NSError *error;
    [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"Error creating object" format:@"%@", error.localizedDescription];
    }
    
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class) inManagedObjectContext:((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
}

+ (instancetype)createItemWithValues:(NSDictionary *)values
{
    NSParameterAssert(values);
    
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class) inManagedObjectContext:((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        for (NSString * key in values.allKeys) {
            if ([name isEqualToString:key]) {
                [obj setValue:values[key] forKey:key];
            }
        }
    }
    
    NSError *error;
    [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"Error creating object" format:@"%@", error.localizedDescription];
    }
    
    return obj;
}

+ (instancetype)itemWithValues:(NSDictionary *)values
{
    NSParameterAssert(values);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NSStringFromClass(self.class) inManagedObjectContext:((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSString *predicateStr = @"";
    NSMutableArray *arr = [NSMutableArray new];
    for (NSString *key in values.allKeys) {
        predicateStr = [predicateStr stringByAppendingString:@"%K == %@ AND "];
        [arr addObjectsFromArray:@[key, values[key]]];
    }
    if ([predicateStr hasSuffix:@" AND "]) {
        predicateStr = [predicateStr substringToIndex:predicateStr.length - 5];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateStr argumentArray:arr];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetched = [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetched.firstObject;
}

+ (instancetype)itemWithProperty:(NSString *)property value:(id)value
{
    NSParameterAssert(property);
    NSParameterAssert(value);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NSStringFromClass(self.class) inManagedObjectContext:((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", property, value];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetched = [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetched.firstObject;
}

- (void)deleteItem
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext deleteObject:self];
    NSError *error;
    [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"Error deleting object" format:@"%@", error.localizedDescription];
    }
}

+ (BOOL)itemExistWithProperty:(NSString *)property value:(id)value
{
    NSParameterAssert(property);
    NSParameterAssert(value);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NSStringFromClass(self.class) inManagedObjectContext:((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", property, value];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetched = [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetched.count > 0;
}

+ (BOOL)itemExistWithValues:(NSDictionary *)values
{
    NSParameterAssert(values);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NSStringFromClass(self.class) inManagedObjectContext:((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSString *predicateStr = @"";
    NSMutableArray *arr = [NSMutableArray new];
    for (NSString *key in values.allKeys) {
        predicateStr = [predicateStr stringByAppendingString:@"%K == %@ AND "];
        [arr addObjectsFromArray:@[key, values[key]]];
    }
    if ([predicateStr hasSuffix:@" AND "]) {
        predicateStr = [predicateStr substringToIndex:predicateStr.length - 5];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateStr argumentArray:arr];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetched = [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetched.count > 0;
}

+ (NSArray *)fetchAllItemsWithPredicates:(NSArray *)predicates sortDescriptors:(NSArray *)sortDescriptors
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NSStringFromClass(self.class) inManagedObjectContext:((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    [fetchRequest setEntity:entity];
    
    for (NSPredicate *predicate in predicates) {
        [fetchRequest setPredicate:predicate];
    }
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *fetched = [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetched;
}

+ (void)saveDataInContext:(void(^)(NSManagedObjectContext *context))block
{
    NSManagedObjectContext *tmpContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    tmpContext.persistentStoreCoordinator = ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentStoreCoordinator;
    
    block(tmpContext);
    
    NSError *error;
    if (![tmpContext save:&error])
    {
        NSLog(@"error saving data: %@", error.localizedDescription);
    }
}

+ (void)save
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext save:nil];
}

@end

