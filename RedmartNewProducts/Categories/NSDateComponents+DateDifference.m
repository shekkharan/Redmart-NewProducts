//
//  NSDateComponents+DateDifference.m
//  ManpowerManagement
//
//  Created by Shekhar  on 7/4/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import "NSDateComponents+DateDifference.h"

@implementation NSDateComponents (DateDifference)

+ (NSUInteger)getDifferenceInDaysBetweenDate1:(NSString *)date1 andDate2:(NSString *)date2
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM ''yy"];
    NSDate *startDate = [formatter dateFromString:date1];
    NSDate *endDate = [formatter dateFromString:date2];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];

    return components.day;
}

@end
