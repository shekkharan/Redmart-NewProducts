//
//  NSDateFormatter+Additions.m
//  iChangi
//
//  Created by Shekhar on 5/5/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import "NSDateFormatter+Additions.h"

@interface NSDateFormatter(Additions_Private)
+ (NSInteger)numDaysAgo:(NSDate*)dat;
+ (NSInteger)numHoursAgo:(NSDate*)date;
+ (NSInteger)numMinutesAgo:(NSDate*)date;
+ (NSInteger)numSecondsAgo:(NSDate*)date;
+ (NSInteger)daysBetweenDate:(NSDate*)date toDate:(NSDate*)toDateTime;
@end

@implementation NSDateFormatter (Additions)

#pragma mark - Init
+(id)newWithFormat:(NSString*)format, ... {
    va_list ap;
    va_start(ap, format);
    NSString *formatterString = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterString];
    return formatter;
}

#pragma mark - Formatting
+(NSString*)stringFromDate:(NSDate*)date withFormat:(NSString*)format, ... {
    va_list ap;
    va_start(ap, format);
    NSString *formatterString = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    
    NSDateFormatter *formatter = [NSDateFormatter newWithFormat:formatterString];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+(NSDate*)dateFromString:(NSString*)dateString withFormat:(NSString*)format, ... {
    va_list ap;
    va_start(ap, format);
    NSString *formatterString = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    
    NSDateFormatter *formatter = [NSDateFormatter newWithFormat:formatterString];
    NSDate *date = [formatter dateFromString:dateString];

    return date;
}

#pragma mark - ISO8601
+(id)newForISO8601 {
    return [NSDateFormatter newWithFormat:@"%@-%@-%@'T'%@:%@:%@%@", YEAR_FORMAT_4, MONTH_FORMAT_NUM, DAY_OF_MONTH_FORMAT_NUM, HOUR_MILITARY_FORMAT, MINUTE_FORMAT, SECOND_FORMAT, TIMEZONE_FORMAT_NUM];
}

+(NSString*)stringFromDateForISO8601:(NSDate*)date {
    NSDateFormatter *formatter = [NSDateFormatter newForISO8601];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+(NSDate*)dateFromStringForISO8601:(NSString*)dateString {
    NSDateFormatter *formatter = [NSDateFormatter newForISO8601];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

#pragma mark - Twitter Date String
+ (NSString*)twitterStringFromDate:(NSDate*)date {
    NSInteger numDaysAgo = [self numDaysAgo:date];
    NSInteger numHoursAgo = [self numHoursAgo:date];
    NSInteger numMinutesAgo = [self numMinutesAgo:date];
    NSInteger numSecondsAgo = [self numSecondsAgo:date];
    
    NSString *dateString;
    
    if(numDaysAgo <= 0) {
        if(numHoursAgo <= 0) {
            if(numMinutesAgo <= 0) {
                if(numSecondsAgo <= 0) {
                    dateString = @"Now";
                } else {
                    dateString = [NSString stringWithFormat:@"%is", numSecondsAgo];
                }
            } else {
                dateString = [NSString stringWithFormat:@"%im", numMinutesAgo];
            }
        } else {
            dateString = [NSString stringWithFormat:@"%ih", numHoursAgo];
        }
    } else if(numDaysAgo == 1) {
        if(numHoursAgo < 24) {
            if(numHoursAgo > 0) {
                dateString = [NSString stringWithFormat:@"%ih", numHoursAgo]; 
            } else {
                dateString = [NSString stringWithFormat:@"%im", numMinutesAgo]; 
            }
        } else {
            dateString = @"1d";
        }
    } else if(numDaysAgo < 3) {
        dateString = [NSString stringWithFormat:@"%id", numDaysAgo];
    } else {
        dateString = [NSDateFormatter stringFromDate:date withFormat:@"%@ %@", DAY_OF_MONTH_FORMAT_NUM, MONTH_FORMAT_ABR];
    }
    
    return dateString;
}

+ (NSInteger)numDaysAgo:(NSDate*)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    return [self daysBetweenDate:date toDate:today];
}

+ (NSInteger)numHoursAgo:(NSDate*)date {    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    return time / 60 / 60;
}

+ (NSInteger)numMinutesAgo:(NSDate*)date {
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    return time / 60;
}

+ (NSInteger)numSecondsAgo:(NSDate*)date {
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    return time;
}

+ (NSInteger)daysBetweenDate:(NSDate*)date toDate:(NSDate*)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:date];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

@end
