//
//  CoreDataController.m
//  Idea Keeper
//
//  Created by Glebus on 17.01.13.
//  Copyright (c) 2013 Domus. All rights reserved.
//

#import "GSCoreDataController.h"
#import "GSFileManager.h"

#define resourceName @"url"
#define baseFileName @"url"

@interface GSCoreDataController()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation GSCoreDataController {
    
}

static GSCoreDataController *instance = nil;

#pragma mark - 
#pragma mark Public methods

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
+ (NSManagedObjectContext *)managedObjectContext {
    GSCoreDataController *coreDataController = [GSCoreDataController instance];
    if (coreDataController.managedObjectContext != nil) {
        return coreDataController.managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        coreDataController.managedObjectContext = [[NSManagedObjectContext alloc] init];
        [coreDataController.managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return coreDataController.managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
+ (NSManagedObjectModel *)managedObjectModel {
    GSCoreDataController *coreDataController = [GSCoreDataController instance];
    if (coreDataController.managedObjectModel != nil) {
        return coreDataController.managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:resourceName withExtension:@"momd"];
    coreDataController.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return coreDataController.managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    GSCoreDataController *coreDataController = [GSCoreDataController instance];
    if (coreDataController.persistentStoreCoordinator != nil) {
        return coreDataController.persistentStoreCoordinator;
    }
    NSString *baseFile = [NSString stringWithFormat:@"%@.sqlite", baseFileName];
    NSURL *storeURL = [[GSFileManager documentsDirectory] URLByAppendingPathComponent:baseFile];
    
    NSError *error = nil;
    coreDataController.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![coreDataController.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return coreDataController.persistentStoreCoordinator;
}

+ (NSArray *)fetchEntitiesWithName:(NSString *)name sortByFiled:(NSString *)sortField ascending:(BOOL)ascending {
    if (!name) {
        return nil;
    }
    
    NSFetchRequest *request = [NSFetchRequest new];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:context];
    [request setEntity:entity];
    
    if (sortField) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortField ascending:ascending];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    }
    
    NSError *error = nil;
    NSArray *fetchResults = [context executeFetchRequest:request error:&error];
    return fetchResults;
}

+ (NSManagedObject *)createEntityWithName:(NSString *)name {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:context];
    return newManagedObject;
}

+ (void)removeEntity:(NSManagedObject *)entity {
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:entity];
}

+ (void)save {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - 
#pragma mark Private methods

+ (GSCoreDataController *)instance {
    @synchronized(self) {
        if (!instance) {
            instance = [self new];
        }
    }
	
    return instance;
}


@end
