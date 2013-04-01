//
//  FileManager.m
//  Idea Keeper
//
//  Created by Glebus on 17.01.13.
//  Copyright (c) 2013 Domus. All rights reserved.
//

#import "GSFileManager.h"

@implementation GSFileManager

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
+ (NSURL *)documentsDirectory
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *documentDirectoryURLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    return [documentDirectoryURLs lastObject];
}

@end
