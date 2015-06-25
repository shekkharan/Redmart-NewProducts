//
//  UIImage+Rescale.h
//  iMyaango
//
//  Created by Shekhar  on 28/8/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rescale)

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

@end
