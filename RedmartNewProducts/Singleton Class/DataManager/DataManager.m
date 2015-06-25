//
//  DataManager.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 10/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "DataManager.h"
#import "UIFlowManager.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Helper.h"
#import "Headers.h"
#import "FileManager.h"
#import "Product.h"

static DataManager* instance;

@interface DataManager()<WebServiceManagerDelegate>

{
    dispatch_queue_t backgroundQueue;
}

@property(nonatomic,strong) NSString *dbPath;

@end

@implementation DataManager


#pragma mark -
#pragma mark INIT

- (id) init {
    if (self = [super init])
    {
        backgroundQueue = dispatch_queue_create("bgqueue", NULL);
        return self;
    }
    return nil;
}

+ (DataManager*) getInstance {
    @synchronized([DataManager class]) {
        
        if ( instance == nil ) {
            instance = [[DataManager alloc] init];
        }
    }
    return instance;
}

#pragma mark -
#pragma mark Archive/Unarchive data

- (void)saveFirstPageofProducts:(NSArray *)data
{
    if (data == (id)[NSNull null]) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        Product *product = [[Product alloc]initWithData:dict];
        [array addObject:product];
    }
    NSString *filePath = [FileManager getFullFilePath:FIRSTPAGE_ARCHIVE_NAME];
    NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:array];
    [NSKeyedArchiver archiveRootObject:theData toFile:filePath];
}

- (NSArray *)loadFirstPageofProducts
{
    NSArray *array = [NSArray array];
    NSData *theData = [NSKeyedUnarchiver unarchiveObjectWithFile:[FileManager getFullFilePath:FIRSTPAGE_ARCHIVE_NAME]];
    array = [NSKeyedUnarchiver unarchiveObjectWithData:theData];
    NSLOG(array);
    return array;
}

@end

