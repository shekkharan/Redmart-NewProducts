//
//  UIView+Border.h
//  iChangi
//
//  Created by Shekhar on 4/29/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

- (void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addAllBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

@end
