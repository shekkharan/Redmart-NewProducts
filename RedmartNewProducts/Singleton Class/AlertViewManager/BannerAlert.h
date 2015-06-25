//
//  BannerAlert.h
//  iRedmart
//
//  Created by Shekhar  on 17/9/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGFashionMenuView.h"

@interface BannerAlert : NSObject

+ (UIView *)createAlertView:(NSString *)text1 withColor:(UIColor *)color1 :(NSString *)text2 withColor:(UIColor *)color2 andWidth:(CGFloat)width;
+ (UIView *)createAlertView:(NSString *)text1 withColor:(UIColor *)color1 :(NSString *)text2 withColor:(UIColor *)color2 andFrame:(CGRect)frame;

+ (void)showAlertView:(MGFashionMenuView *)alertview;
+ (void)showAlertViewAndFade:(MGFashionMenuView *)alertview;

@end
