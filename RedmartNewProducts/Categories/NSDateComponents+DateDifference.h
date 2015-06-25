//
//  NSDateComponents+DateDifference.h
//  ManpowerManagement
//
//  Created by Shekhar  on 7/4/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponents (DateDifference)

+ (NSUInteger)getDifferenceInDaysBetweenDate1:(NSString *)date1 andDate2:(NSString *)date2;

@end
