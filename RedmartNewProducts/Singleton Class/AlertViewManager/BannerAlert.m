//
//  BannerAlert.m
//  iRedmart
//
//  Created by Shekhar  on 17/9/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import "BannerAlert.h"
#import "Headers.h"
#import "MGFashionMenuView.h"
#import "Constants.h"


@implementation BannerAlert

+ (UIView *)createAlertView:(NSString *)text1 withColor:(UIColor *)color1 :(NSString *)text2 withColor:(UIColor *)color2 andWidth:(CGFloat)width
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,width, 60)];
    [view setBackgroundColor:APPTERTIARYCOLOR];
    
    UILabel *lblItemAdded = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, width - 10, 20)];
    [lblItemAdded setText:text1];
    [lblItemAdded setTextAlignment:NSTextAlignmentCenter];
    [lblItemAdded setTextColor:color1];
    lblItemAdded.font = FONTREGULAR(14);
    [view addSubview:lblItemAdded];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, width - 10, 15)];
    [lbl setText:text2];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:color2];
    lbl.font = FONTREGULAR(12);
    [view addSubview:lbl];

    
    return view;
}

+ (UIView *)createAlertView:(NSString *)text1 withColor:(UIColor *)color1 :(NSString *)text2 withColor:(UIColor *)color2 andFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:APPTERTIARYCOLOR];
    
    UILabel *lblItemAdded = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 20)];
    [lblItemAdded setText:text1];
    [lblItemAdded setTextAlignment:NSTextAlignmentCenter];
    [lblItemAdded setTextColor:color1];
    lblItemAdded.font = FONTREGULAR(12);
    [view addSubview:lblItemAdded];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, frame.size.width, 15)];
    [lbl setText:text2];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:color2];
    lbl.font = FONTREGULAR(12);
    [view addSubview:lbl];
    
    
    return view;
}

+ (void)showAlertView:(MGFashionMenuView *)alertview
{
    [alertview show];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [alertview hide];
                       
                       dispatch_time_t removeTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC));
                       dispatch_after(removeTime, dispatch_get_main_queue(), ^(void)
                                      
                                      {
                                          [alertview removeFromSuperview];
                                      });
                       
                   });

}

+ (void)showAlertViewAndFade:(MGFashionMenuView *)alertview
{
    [alertview show];
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [alertview hide];
                       CATransition *animation = [CATransition animation];
                       animation.type = kCATransitionFade;
                       animation.duration = 0.4;
                       [alertview.superview.layer addAnimation:animation forKey:nil];
                       [alertview removeFromSuperview];
                                    
                       
                   });
    
}


@end
