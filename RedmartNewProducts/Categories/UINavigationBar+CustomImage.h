//
//  UINavigationBar+CustomImage.h
//  ManpowerManagement
//
//  Created by Shekhar  on 31/12/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CustomImage)

- (void) setBackgroundImage:(UIImage*)image;
- (void) clearBackgroundImage;
- (void) removeIfImage:(id)sender;
@end