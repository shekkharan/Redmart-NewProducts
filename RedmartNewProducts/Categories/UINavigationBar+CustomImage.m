//
//  UINavigationBar+CustomImage.m
//  ManpowerManagement
//
//  Created by Shekhar  on 31/12/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import "UINavigationBar+CustomImage.h"

@implementation UINavigationBar (CustomImage)

- (void) setBackgroundImage:(UIImage*)image {
    if (image == NULL) return;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(110,5,100,30);
    [self addSubview:imageView];
    
}

- (void) clearBackgroundImage {
    NSArray *subviews = [self subviews];
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i]  isMemberOfClass:[UIImageView class]]) {
            [[subviews objectAtIndex:i] removeFromSuperview];
        }
    }
}

@end