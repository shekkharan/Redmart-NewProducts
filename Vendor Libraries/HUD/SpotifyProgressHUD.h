//
//  ProgressView.h
//  testdel
//
//  Created by Paolo Boschini on 8/8/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpotifyProgressHUD : UIView

+ (void)showHUDInView:(UIView *)view withColor:(UIColor *)color;
+ (void)dismissHUDInView:(UIView *)view;
+ (BOOL)HUDExists:(UIView *)view;

- (instancetype)initWithFrame:(CGRect)frame withColor:(UIColor *)color withBGColor:(UIColor *)bgcolor withPointDiameter:(int)diameter withInterval:(float)interval;

- (void)dismiss;
- (void)show;
@end