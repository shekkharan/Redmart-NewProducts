//
//  CustomNavigationBar.m
//  CAGAppHd
//
//  Created by Shekhar on 2012-02-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// http://stackoverflow.com/questions/704558/custom-uinavigationbar-background

#import "CustomNavigationBar.h"
#import "UIImage+UISegmentIconAndText.h"
#import "Constants.h"

@implementation CustomNavigationBar

//- (void)setNeedsDisplay
//
//{
//    self.backgroundColor = APPTERTIARYCOLOR;
//}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//    UILabel *label = [[UILabel alloc]init];
//    [label drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    label.text = @"Malaysian News";
//    label.font = WWFONTHEAVY(17);
//    label.textColor = [UIColor colorWithRed:17.0/255.0 green:66.0/255.0 blue:143.0/255.0 alpha:0.8];
//    
//    [label drawInRect:CGRectMake(self.frame.size.width-label.size.width-120, (self.frame.size.height-label.size.height)/2, label.size.width, label.size.height)];
//
    
    UIImage *image = [UIImage imageNamed:nil];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    image = [UIImage imageFromImage:[UIImage imageNamed:@"Icon"] string:@" Redmart" fontSize:17 color:APPPRIMARYCOLOR];
    [image drawInRect:CGRectMake(self.frame.size.width-image.size.width-110, (self.frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
}

@end