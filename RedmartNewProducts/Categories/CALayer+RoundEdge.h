//
//  CALayer+RoundEdge.h
//  Surveys_ipad
//
//  Created by Shekhar on 4/22/14.
//  Copyright (c) 2014 App-solutely Private Limited. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (RoundEdge)

+ (id)maskLayerWithCorners:(UIRectCorner)corners radii:(CGSize)radii frame:(CGRect)frame;

@end
