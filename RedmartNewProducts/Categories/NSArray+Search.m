//
//  NSArray+Search.m
//  ManpowerManagement
//
//  Created by Shekhar on 20/11/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import "NSArray+Search.h"

@implementation NSArray (Search)

- (BOOL)checkIfExistsInCache:(NSString *)aString  {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches[c] %@",aString];
    NSArray *results = [self filteredArrayUsingPredicate:predicate];
    if ([results count]) return YES;
    return NO;
}

- (NSArray *)searchInCache:(NSString *)aString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",aString];
    NSArray *results = [self filteredArrayUsingPredicate:predicate];
    return results;
}

@end
