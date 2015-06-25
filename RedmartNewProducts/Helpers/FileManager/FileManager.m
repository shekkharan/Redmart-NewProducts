//
//  FileManager.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 10/4/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "FileManager.h"
#import "Constants.h"
#import "NSDateComponents+DateDifference.h"

@implementation FileManager

+ (BOOL)fileCopied:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *filePath = [documentsDir stringByAppendingPathComponent:fileName];
    BOOL success = [fileManager fileExistsAtPath:filePath];
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:filePath error:&error];
        if (!success) {
            NSLog(@"Failed to create writable File. Error '%@'.", [error localizedDescription]);
        } else {
            NSLog(@"File copied.");
        }
    }
    else
    {
        NSLog(@"File exists, no need to copy.");
    }
    return success;
}

//- (BOOL)checkIfFileFolderExists
//{
//   NSError * error = nil;
//   [[NSFileManager defaultManager] createDirectoryAtPath:bundlePath
//                          withIntermediateDirectories:YES
//                                           attributes:nil
//                                                error:&error];
//    if (error != nil) {
//    NSLog(@"error creating directory: %@", error);
//    //..
//}

+ (NSString *)getFilePathWithName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathComponent = fileName;
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:pathComponent];
    return filePath;
}

+ (void)saveFileWithName:(NSString *)fileName andData:(NSData *)data
{
    [data writeToFile:[self getFilePathWithName:fileName] atomically:YES];
}

+ (NSData *)readDataFromFileWithName:(NSString *)fileName
{
    NSData *data = [[NSData alloc]initWithContentsOfFile:[self getFilePathWithName:fileName]];
    return data;
}

+ (void)clearOldCache
{
//    NSFileManager *fileMgr = [[NSFileManager alloc] init];
//    NSError *error = nil;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
//    
//    for (id obj in files){
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
//        if (error == nil) {
//            for (NSString *path in directoryContents) {
//                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
//                NSDictionary *attrs = [fileMgr attributesOfItemAtPath:fullPath error:nil];
//                if (attrs != nil) {
//                    NSDate *createdDate = (NSDate*)[attrs objectForKey: NSFileCreationDate];
//                    NSInteger dayDifference = [NSDateComponents getDifferenceInDaysBetweenNSDate1:createdDate andDate2:[NSDate date]];
//                    if (dayDifference > 30) {
//                        BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
//                        files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
//                        if (removeSuccess) {
//                            NSLog(@"Removed %@",fullPath);
//                        }
//                    }
//                }
//            }
//        } else {
//            // Error
//        }
//    }
}

+ (void)emptySandbox
{
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    while (files.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
                if (removeSuccess) {
                    NSLog(@"Removed %@",fullPath);
                }
            }
        } else {
            // Error
        }
    }
}

+ (void)deleteDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSLog(@"Path: %@", [paths objectAtIndex:0]);
        
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Remove all files in the documents directory
        BOOL deleted = [fileManager removeItemAtPath:[paths objectAtIndex:0] error:&error];
        
        if (deleted != YES || error != nil)
        {
            // Deal with the error...
        }
        else
            // Recreate the Documents directory
            [fileManager createDirectoryAtPath:[paths objectAtIndex:0] withIntermediateDirectories:NO attributes:nil error:&error];
        
    }
}

+ (NSString*) getFullFilePath:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *savePath = [paths objectAtIndex:0];
    NSString *theFileName = [NSString stringWithFormat:@"%@.setting", name];
    return [savePath stringByAppendingPathComponent: theFileName];
}

+ (void)removeFile:(NSString *)name
{
    NSString *filePath = [FileManager getFullFilePath:name];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:filePath error:nil];
}

@end
