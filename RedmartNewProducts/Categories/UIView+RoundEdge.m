//
//  UIImageView+RoundEdge.m
//  Surveys_ipad
//
//  Created by Shekhar on 4/22/14.
//  Copyright (c) 2014 App-solutely Private Limited. All rights reserved.
//

#import "UIView+RoundEdge.h"


@implementation UIView (RoundEdge)

- (void)maskRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    // To round all corners, we can just set the radius on the layer
    if ( corners == UIRectCornerAllCorners ) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
    } else {
        // If we want to choose which corners we want to mask then
        // it is necessary to create a mask layer.
        self.layer.mask = [CALayer maskLayerWithCorners:corners radii:CGSizeMake(radius, radius) frame:self.bounds];
    }
}

@end
