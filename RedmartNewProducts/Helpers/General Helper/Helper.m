//
//  Helper.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 22/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import "Helper.h"
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "NSDateComponents+DateDifference.h"
#import "MBProgressHUD.h"

@implementation Helper

+ (void)showAnimationOnViewWillAppear:(UIView *)view withDuration:(NSTimeInterval)duration
{
    for (UIView *subView in view.subviews)
    {
        subView.hidden = YES;
    }
    
    dispatch_time_t showTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC));
    dispatch_after(showTime, dispatch_get_main_queue(), ^(void)
                   {
                       [Helper showAnimationOnView:view withDuration:duration];
                       for (UIView *subView in view.subviews)
                       {
                           subView.hidden = NO;
                       }
                   });
}

+ (void)hideAllSubviewsinView:(UIView *)view
{
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            subView.hidden = NO;
        }
        subView.hidden = YES;
    }
    
}

+ (void)showViewWithAnimation:(UIView *)view withDuration:(NSTimeInterval)duration
{
    view.hidden = YES;
    
    dispatch_time_t showTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC));
    dispatch_after(showTime, dispatch_get_main_queue(), ^(void)
                   {
                       [Helper showAnimationOnView:view withDuration:duration];
                           view.hidden = NO;
                   });
}

+ (void)showAnimationOnView:(UIView *)view withDuration:(NSTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = duration;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)showAnimationOnView:(UIView *)view withDuration:(NSTimeInterval)duration withType:(NSString*)type
{
    CATransition *animation = [CATransition animation];
    animation.type = type;
    animation.duration = duration;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)showCountingAnimationOnLabels:(NSMutableArray *)countLabels
{
    for (CountLabel *countLabel in countLabels) {
        [countLabel.label addCountingAnimationwithNumber:[countLabel.count doubleValue]];
        
    }
}

+ (float)expectedHeightOfLabelOfWidth:(CGFloat)width withString:(NSString *)text andFont:(UIFont *)font
{
    CGSize maximumLabelSize = CGSizeMake(width,9999);
    CGSize expectedLabelSize = [text sizeWithFont:font
                                constrainedToSize:maximumLabelSize
                                    lineBreakMode:NSLineBreakByWordWrapping];
    return expectedLabelSize.height;
}


+ (NSInteger)compareTime:(NSDate *)observationTime atTimeZone:(NSTimeZone *)timeZone
{
    NSDate *systemTime = [NSDate date];

    NSTimeInterval distanceBetweenTimes = [systemTime timeIntervalSinceDate:observationTime];
    double secondsInAnHour = 3600;
    NSInteger minutesBetweenTimes = distanceBetweenTimes * 60 / secondsInAnHour;

    return abs(minutesBetweenTimes);
}

+ (NSString *)formatDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *formatted = [dateFormatter stringFromDate:date];
    //    [dateFormatter release];
    return formatted;
}

+ (NSDate *)parseDate:(NSString *)str withFormat:(NSString *)format
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [dateFormatter dateFromString:str];
    
    return date;
}




+ (int)getLocalization:(NSString *)localization
{
    if (EQUALS(localization, kEnglish)) {
        return ENGLISH;
    }
    return CHINESE;
}


@end
