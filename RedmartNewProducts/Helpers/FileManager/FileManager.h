//
//  FileManager.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 10/4/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (BOOL)fileCopied:(NSString *)fileName;
+ (NSString *)getFilePathWithName:(NSString *)fileName;
+ (void)saveFileWithName:(NSString *)fileName andData:(NSData *)data;
+ (NSData *)readDataFromFileWithName:(NSString *)fileName;
+ (void)emptySandbox;
+ (void)deleteDocumentDirectory;
+ (void)clearOldCache;
+ (NSString*) getFullFilePath:(NSString*)name;
+ (void)removeFile:(NSString *)name;

@end
