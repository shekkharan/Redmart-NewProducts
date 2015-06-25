//
//  Helper.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 22/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CountLabel.h"

@interface Helper : NSObject

//UI
+ (void)showAnimationOnView:(UIView *)view withDuration:(NSTimeInterval)duration withType:(NSString*)type;
+ (void)showAnimationOnView:(UIView *)view withDuration:(NSTimeInterval)duration;
+ (void)hideAllSubviewsinView:(UIView *)view;
+ (void)showAnimationOnViewWillAppear:(UIView *)view withDuration:(NSTimeInterval)duration;
+ (void)showViewWithAnimation:(UIView *)view withDuration:(NSTimeInterval)duration;

//Label
+ (void)showCountingAnimationOnLabels:(NSMutableArray *)countLabels;
+ (float)expectedHeightOfLabelOfWidth:(CGFloat)width withString:(NSString *)text andFont:(UIFont *)font;


//Time/Date
+ (NSInteger)compareTime:(NSDate *)observationTime atTimeZone:(NSTimeZone *)timeZone;
+ (NSString *)formatDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSDate *)parseDate:(NSString *)str withFormat:(NSString *)format;


//Localization
+ (int)getLocalization:(NSString *)localization;

@end
