//
//  UpdateHUD.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 21/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "SpotifyProgressHUD.h"

typedef void (^DoneBlock)(BOOL);

@interface UpdateHUD : NSObject
{
    UIWindow *appWindow;
}

+ (void)addMBProgressUpdating:(UIView *)view;
+ (void)addActivityController:(UIView *)view;
+ (void)addMBProgress:(UIView *)view withText:(NSString *)message;
+ (void)removeMBProgress:(UIView *)view;
+ (void)removeActivityController:(UIView *)view;
+ (void)removeMBProgress:(UIView *)view onCompletion:(DoneBlock)compBlock;
+ (void)addSpotifyHUDSplash:(UIView *)view;
+ (void)addSpotifyHUD:(UIView *)view withColor:(UIColor *)color;
+ (void)removeSpotifyHUD:(UIView *)view;

@end
