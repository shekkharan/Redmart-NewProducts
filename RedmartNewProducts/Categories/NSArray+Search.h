//
//  NSArray+Search.h
//  ManpowerManagement
//
//  Created by Shekhar on 20/11/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Search)


- (BOOL)checkIfExistsInCache:(NSString *)aString;
/**
 Get Saved Locations
 */
- (NSArray *)searchInCache:(NSString *)aString;
@end
