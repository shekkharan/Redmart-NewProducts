//
//  UIFlowManager.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 10/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "UIFlowManager.h"
#import "AppDelegate.h"
#import "WebServiceManager.h"
#import "SplashScreenVC.h"
#import "JASidePanelController.h"
#import "Constants.h"
#import "Helper.h"
#import "ProductsCatalogueVC.h"

static UIFlowManager* instance;

@interface UIFlowManager()<WebServiceManagerDelegate>

{
    UIWindow *mainWindow;
    dispatch_queue_t backgroundQueue;
    dispatch_queue_t cacheClear;
}

@end

@implementation UIFlowManager

- (id) init {
    if (self = [super init])
    {
        mainWindow = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window;
        return self;
    }
    return nil;
}

+ (UIFlowManager*) getInstance {
    @synchronized([UIFlowManager class]) {
        
        if ( instance == nil ) {
            instance = [[UIFlowManager alloc] init];
        }
    }
    return instance;
}

- (void)checkFirstLaunch
{
    //first launch of the app
    if (FIRSTLAUNCH)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kHasLaunchedOnce];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:ENGLISH] forKey:USERDEFAULTS_LANGUAGETYPE];
        SET_PUSHNOTIFICATIONENABLED(YES);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:REMEMBER_ME];
        SET_AUTHENTICATIONTOKEN(BLANK);

        SET_LOGIN_NAME(BLANK);
        SET_PUSHTOKEN(BLANK);
        if (EQUALS(SYSTEMLANGUAGE, kChinese)) {
            SET_LOCALIZATION(kChinese);
        }
        else SET_LOCALIZATION(kEnglish);
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

- (void)launchApp
{
    mainWindow.backgroundColor = APPPRIMARYCOLOR;
    [mFlowManager loadSplash];
    [mFlowManager performSelector:@selector(loadProductsCatalogue) withObject:nil afterDelay:3.0];
}

- (void)loadSplash
{
    mainWindow.rootViewController =  [[SplashScreenVC alloc] init];
    [mainWindow makeKeyAndVisible];
}

- (void)loadProductsCatalogue
{
    [UpdateHUD removeSpotifyHUD:CURRENT_VIEW];
    
    ProductsCatalogueVC *vc = [[ProductsCatalogueVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    mainWindow.rootViewController = nav;
    [mainWindow makeKeyAndVisible];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [mainWindow.layer addAnimation:animation forKey:nil];
    
}

@end
