//
//  CoreDataController.h
//  Idea Keeper
//
//  Created by Glebus on 17.01.13.
//  Copyright (c) 2013 Domus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataController : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataController *)instance;
+ (NSArray *)fetchEntitiesWithName:(NSString *)name sortByFiled:(NSString *)sortField ascending:(BOOL)ascending;
+ (id)createEntityWithName:(NSString *)name;
+ (void)removeEntity:(NSManagedObject *)entity;
+ (void)save;

@end
