//
//  UILabel+DynamicResize.h
//  iChangi
//
//  Created by Shekhar on 6/5/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DynamicResize)

-(float)resizeToFit;
-(float)expectedHeight;

@end