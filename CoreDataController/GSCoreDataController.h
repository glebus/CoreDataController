//
//  CoreDataController.h
//  Idea Keeper
//
//  Created by Glebus on 17.01.13.
//  Copyright (c) 2013 Domus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSCoreDataController : NSObject

+ (NSManagedObjectContext *)managedObjectContext;
+ (NSManagedObjectModel *)managedObjectModel;
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

+ (NSArray *)fetchEntitiesWithName:(NSString *)name sortByFiled:(NSString *)sortField ascending:(BOOL)ascending;
+ (NSManagedObject *)createEntityWithName:(NSString *)name;
+ (void)removeEntity:(NSManagedObject *)entity;
+ (void)save;

@end
