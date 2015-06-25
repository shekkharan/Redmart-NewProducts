//
//  ProgressView.m
//  testdel
//
//  Created by Paolo Boschini on 8/8/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import "SpotifyProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

@interface CircleView : UIView
@property (nonatomic,strong)UIColor *circleColor;
@end

@implementation CircleView

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color {
    if (self = [super initWithFrame:frame]) {
        self.opaque = NO;
        self.circleColor = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.circleColor.CGColor);
    CGContextFillEllipseInRect(context, rect);
}
@end

@interface SpotifyProgressHUD () {
    CircleView *leftCircle;
    CircleView *middleCircle;
    CircleView *rightCircle;
}

@property (nonatomic,strong)UIColor *dotColor;
@property float interval;
@property int pointDiameter;

@end

@implementation SpotifyProgressHUD

+ (void)showHUDInView:(UIView *)view withColor:(UIColor *)color {
    SpotifyProgressHUD *progressView = [self findHUDInView:view];
    if (!progressView)
    {
        progressView = [[SpotifyProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 130, 130) withColor:color withBGColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] withPointDiameter:15 withInterval:0.25];
        progressView.center = view.center;
        [view addSubview:progressView];
    } else {
        [progressView show];
    }
}

+ (void)dismissHUDInView:(UIView *)view {
    SpotifyProgressHUD *progressView = [self findHUDInView:view];
    if (progressView) {
        [progressView dismiss];
    }
}

+ (BOOL)HUDExists:(UIView *)view {
    SpotifyProgressHUD *progressView = [self findHUDInView:view];
    if (progressView) {
        return YES;
    }
    return NO;
}

+ (SpotifyProgressHUD *)findHUDInView:(UIView *)view {
    SpotifyProgressHUD *progressView = nil;
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[SpotifyProgressHUD class]]) {
            progressView = (SpotifyProgressHUD *)subview;
        }
    }
    return progressView;
}

- (instancetype)initWithFrame:(CGRect)frame withColor:(UIColor *)color withBGColor:(UIColor *)bgcolor withPointDiameter:(int)diameter withInterval:(float)interval {
    if ((self = [super initWithFrame:frame])) {
        
        self.interval = interval;
        self.pointDiameter = diameter;
        self.dotColor = color;
        self.backgroundColor = bgcolor;
        self.layer.cornerRadius = 8;
        
        leftCircle = [self addCircleViewWithXOffsetFromCenter:-27.5];
        middleCircle = [self addCircleViewWithXOffsetFromCenter:0];
        rightCircle = [self addCircleViewWithXOffsetFromCenter:27.5];
        
        [self addAnimationsToCircles];
    }
    return self;
}

- (CircleView*)addCircleViewWithXOffsetFromCenter:(float)offset {
    CGRect rect = CGRectMake(0, 0, self.pointDiameter, self.pointDiameter);
    CircleView *circle = [[CircleView alloc] initWithFrame:rect andColor:self.dotColor];
    circle.center = self.center;
    circle.frame = CGRectOffset(circle.frame, offset, 0);
    [self addSubview:circle];
    return circle;
}

- (void)addAnimationsToCircles {
    CAKeyframeAnimation *circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.xy"];
    circleAnimation.values = @[@1, @1.65, @1];
    circleAnimation.keyTimes = @[@0, @0.5, @1];
    circleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],];
    circleAnimation.duration = 0.6;
    
    CGFloat animationDuration = self.interval * 5 + 0.2;
    
    CAAnimationGroup *leftCircleAnimation = [CAAnimationGroup animation];
    leftCircleAnimation.duration = animationDuration;
    leftCircleAnimation.beginTime = CACurrentMediaTime() + self.interval;
    leftCircleAnimation.repeatCount = HUGE_VALF;
    leftCircleAnimation.animations = @[circleAnimation];
    
    CAAnimationGroup *middleCircleAnimation = [CAAnimationGroup animation];
    middleCircleAnimation.duration = animationDuration;
    middleCircleAnimation.beginTime = CACurrentMediaTime() + self.interval * 1.75;
    middleCircleAnimation.repeatCount = HUGE_VALF;
    middleCircleAnimation.animations = @[circleAnimation];
    
    CAAnimationGroup *rightCircleAnimation = [CAAnimationGroup animation];
    rightCircleAnimation.duration = animationDuration;
    rightCircleAnimation.beginTime = CACurrentMediaTime() + self.interval * 2.5;
    rightCircleAnimation.repeatCount = HUGE_VALF;
    rightCircleAnimation.animations = @[circleAnimation];
    
    [leftCircle.layer addAnimation:leftCircleAnimation forKey:nil];
    [middleCircle.layer addAnimation:middleCircleAnimation forKey:nil];
    [rightCircle.layer addAnimation:rightCircleAnimation forKey:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 30, self.frame.size.width, self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 30, self.frame.size.width, self.frame.size.height);
    }];
    [self removeFromSuperview];
}

- (void)show {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1;
    } completion:nil];
}

@end