//
//  UpdateHUD.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 21/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import "UpdateHUD.h"
#import "Constants.h"

@implementation UpdateHUD

+ (void)addMBProgress:(UIView *)view withText:(NSString *)message
{
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[MBProgressHUD class]])
        {
            return;
        }
    }
    MBProgressHUD *mbProgressView = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:mbProgressView];
    mbProgressView.labelText = message;
    [mbProgressView show:YES];
}

+ (void)addActivityController:(UIView *)view
{
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[UIActivityIndicatorView class]])
        {
            return;
        }
    }
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityView.center = view.center;
    [activityView startAnimating];
    [view addSubview:activityView];
}

+ (void)addMBProgressUpdating:(UIView *)view
{
    MBProgressHUD *mbProgressView = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:mbProgressView];
    mbProgressView.labelText = @"Updating..";
    [mbProgressView show:YES];
}

+ (void)removeMBProgress:(UIView *)view
{
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[MBProgressHUD class]])
        {
            CATransition *animation = [CATransition animation];
            animation.type = kCATransitionFade;
            animation.duration = 0.4;
            [view.layer addAnimation:animation forKey:nil];
            [subView removeFromSuperview];
        }
    }
}

+ (void)removeActivityController:(UIView *)view
{
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[UIActivityIndicatorView class]])
        {
            CATransition *animation = [CATransition animation];
            animation.type = kCATransitionFade;
            animation.duration = 0.4;
            [view.layer addAnimation:animation forKey:nil];
            [subView removeFromSuperview];
        }
    }
}

+ (void)removeMBProgress:(UIView *)view onCompletion:(DoneBlock)compBlock
{
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[MBProgressHUD class]])
        {
            CATransition *animation = [CATransition animation];
            animation.type = kCATransitionFade;
            animation.duration = 0.4;
            [view.layer addAnimation:animation forKey:nil];
            [subView removeFromSuperview];
        }
    }
    if (compBlock)compBlock(YES);
}


+ (void)addSpotifyHUDSplash:(UIView *)view
{
    if ([SpotifyProgressHUD HUDExists:view]) {
        return ;
    }
    SpotifyProgressHUD *progressView = [[SpotifyProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 150, 150) withColor:WHITECOLOR withBGColor:[UIColor clearColor] withPointDiameter:16 withInterval:0.25];
    
    progressView.center = CGPointMake(view.center.x, view.center.y + 90);
    [view addSubview:progressView];
}

+ (void)addSpotifyHUD:(UIView *)view withColor:(UIColor *)color
{
    [SpotifyProgressHUD showHUDInView:view withColor:color];
}

+ (void)removeSpotifyHUD:(UIView *)view
{
    [SpotifyProgressHUD dismissHUDInView:view];
}

@end
