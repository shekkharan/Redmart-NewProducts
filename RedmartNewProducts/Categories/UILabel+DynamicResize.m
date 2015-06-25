//
//  UILabel+DynamicResize.m
//  iChangi
//
//  Created by Shekhar on 6/5/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import "UILabel+DynamicResize.h"

@implementation UILabel (DynamicResize)

-(float)resizeToFit{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    return newFrame.origin.y + newFrame.size.height;
}

-(float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,9999);
    
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:NSLineBreakByCharWrapping];
    return expectedLabelSize.height;
}

@end