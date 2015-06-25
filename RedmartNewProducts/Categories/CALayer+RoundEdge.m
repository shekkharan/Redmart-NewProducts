//
//  CALayer+RoundEdge.m
//  Surveys_ipad
//
//  Created by Shekhar on 4/22/14.
//  Copyright (c) 2014 App-solutely Private Limited. All rights reserved.
//

#import "CALayer+RoundEdge.h"

@implementation CALayer (RoundEdge)

+ (id)maskLayerWithCorners:(UIRectCorner)corners radii:(CGSize)radii frame:(CGRect)frame {
    
    // Create a CAShapeLayer
    CAShapeLayer *mask = [CAShapeLayer layer];
    
    // Set the frame
    mask.frame = frame;
    
    // Set the CGPath from a UIBezierPath
    mask.path = [UIBezierPath bezierPathWithRoundedRect:mask.bounds byRoundingCorners:corners cornerRadii:radii].CGPath;
    
    // Set the fill color
    mask.fillColor = [UIColor whiteColor].CGColor;
    
    return mask;
}

@end
