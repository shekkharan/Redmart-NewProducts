//
//  UIImage+UISegmentIconAndText.h
//  iChangi
//
//  Created by Shekhar on 5/5/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UISegmentIconAndText)

+ (id) imageFromImage:(UIImage*)image string:(NSString*)string color:(UIColor*)color;

+ (id) imageFromImage:(UIImage*)image string:(NSString*)string fontSize:(CGFloat)fontSize color:(UIColor*)color;

+ (id) imageFromImage:(UIImage*)image string:(NSString*)string font:(UIFont *)font color:(UIColor*)color;

+ (id) scaleImage:(UIImage *)image toSize:(CGSize)newSize;

@end
