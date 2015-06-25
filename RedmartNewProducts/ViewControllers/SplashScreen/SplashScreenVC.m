//
//  SplashScreenVC.m
//  AnalyticsTestApp
//
//  Created by Shekhar  on 17/12/14.
//  Copyright (c) 2014 SilverCoastCorp. All rights reserved.
//

#import "SplashScreenVC.h"
#import "Constants.h"
#import "UpdateHUD.h"

@interface SplashScreenVC ()
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imgBG;
@property (weak, nonatomic) IBOutlet UIImageView *imgMart;
@property (weak, nonatomic) IBOutlet UIImageView *imgRed;
@property (weak, nonatomic) IBOutlet UIImageView *imgTrademark;

@end

@implementation SplashScreenVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(animateOnEntry) withObject:nil afterDelay:0.6];
}

- (void) animateOnEntry
{
    __block __weak typeof(self) weakSelf = self;
    
    weakSelf.imgRed.alpha = 0;
    weakSelf.imgMart.alpha = 0;
    weakSelf.imgRed.frame = CGRectMake(self.imgRed.frame.origin.x - self.view.frame.size.width , self.imgRed.frame.origin.y, self.imgRed.frame.size.width, self.imgRed.frame.size.height);
    
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
         weakSelf.imgRed.hidden = NO;
         weakSelf.imgRed.frame = CGRectMake(self.view.frame.size.width + weakSelf.imgRed.frame.origin.x,  weakSelf.imgRed.frame.origin.y, weakSelf.imgRed.frame.size.width, weakSelf.imgRed.frame.size.height);

         weakSelf.imgRed.alpha = 1;
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
             CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.05, 1.05);
             weakSelf.imgRed.transform = scaleTransform;
         }completion:^(BOOL finished)
          {
              CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.0, 1.0);
              weakSelf.imgRed.transform = scaleTransform;

              weakSelf.imgMart.frame = CGRectMake(weakSelf.imgMart.frame.origin.x + weakSelf.imgMart.frame.size.width + weakSelf.view.frame.size.width , weakSelf.imgMart.frame.origin.y, weakSelf.imgMart.frame.size.width, weakSelf.imgMart.frame.size.height);
              [UIView animateWithDuration:0.2f
                                    delay:0
                                  options:UIViewAnimationOptionCurveEaseInOut
                               animations:^(void)
               {
                   NSLog(@"%f",weakSelf.imgMart.frame.origin.x);
                   weakSelf.imgMart.hidden = NO;
                   weakSelf.imgMart.frame = CGRectMake(weakSelf.imgMart.frame.origin.x - weakSelf.view.frame.size.width - weakSelf.imgMart.frame.size.width ,  weakSelf.imgMart.frame.origin.y, weakSelf.imgMart.frame.size.width, weakSelf.imgMart.frame.size.height);
                   weakSelf.imgMart.alpha = 1;
               }
                               completion:^(BOOL finished){
                                   [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
                                       CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.15, 1.15);
                                       weakSelf.imgMart.transform = scaleTransform;
                                   }completion:^(BOOL finished)
                                    {
                                        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.0, 1.0);
                                        weakSelf.imgMart.transform = scaleTransform;
                                        [self performSelector:@selector(showTrademark) withObject:nil afterDelay:0.4];
                                    }];
                               }];

          }];
     }];
}

- (void)showTrademark
{
    self.imgTrademark.hidden = NO;
    [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.35,1.35);
        self.imgTrademark.transform = scaleTransform;
    }completion:^(BOOL finished)
     {
         CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.0, 1.0);
         self.imgTrademark.transform = scaleTransform;
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
