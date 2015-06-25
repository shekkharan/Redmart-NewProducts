//
//  AlertViewManager.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 30/12/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import "AlertViewManager.h"
#import "Session.h"
#import "Constants.h"

NSString *kSound = @"%@/right_answer.mp3";
NSString *kLogoutTitle = @"Logout";
NSString *kErrorTitle = @"Error";
NSString *kNetworkErrorTitle = @"Connection error";
NSString *kWebserviceErrorTitle = @"Request error";
NSString *kWebserviceSuccessTitle = @"Success";
NSString *kNoticeTitle = @"Notice";
NSString *kWarningTitle = @"Warning";
NSString *kInfoTitle = @"Info";
NSString *kLogoutSubtitle = @"Are you sure you want to logout?";
NSString *kNetworkErrorSubtitle = @"Please check you network connection.";
//NSString *kWebserviceErrorSubtitle = @"Please check you network connection.";
NSString *kCancel = @"Cancel";
NSString *kOk = @"Ok";
NSString *kAttributeTitle = @"Attributed string operation successfully completed.";

static AlertViewManager *instance;

@implementation AlertViewManager

- (id) init {
    if (self = [super init])
    {
        self.isAlertViewActive = NO;
        return self;
    }
    return nil;
}

+ (AlertViewManager*) getInstance {
    @synchronized([AlertViewManager class]) {
        if ( instance == nil ) {
            instance = [[AlertViewManager alloc] init];
        }
    }
    return instance;
}

- (BOOL)alertViewExists
{
    return self.isAlertViewActive;
}

- (void)setAlertViewActive:(BOOL)status
{
    self.isAlertViewActive = status;
}

#pragma mark -
#pragma mark Logout Alert

- (void)showLogoutAlert:(CompletionBlock)compBlock
{
//    SCLAlertView *alert = [[SCLAlertView alloc] init];
//    
//    SCLButton *button = [alert addButton:LOCALIZATION(C_LOGOUT_YES) actionBlock:^(void) {
//        if (compBlock)compBlock(YES);
//    }];
//    
//    button.layer.borderWidth = 2.0f;
//    
//    button.buttonFormatBlock = ^NSDictionary* (void)
//    {
//        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
//        
//        buttonConfig[@"backgroundColor"] = [UIColor whiteColor];
//        buttonConfig[@"textColor"] = APPSECONDARYCOLOR;
//        buttonConfig[@"borderColor"] = APPSECONDARYCOLOR;
//        
//        return buttonConfig;
//    };
//    
//    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:kSound, [[NSBundle mainBundle] resourcePath]]];
    
    //alert showInfo:CURRENT_VIEWCONTROLLER title:LOCALIZATION(C_LOGOUT_TITLE) subTitle:LOCALIZATION(C_LOGOUT_MSG) closeButtonTitle:LOCALIZATION(C_LOGOUT_NO) duration:0.0f];
}

#pragma mark -
#pragma mark Webservice Alert Alert

- (void)showNetworkErrorAlert:(NSString *)message onCompletion:(CompletionBlock)compBlock
{
    if ([self alertViewExists])return;
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:kSound, [[NSBundle mainBundle] resourcePath]]];
    alert.dismissBlock = ^{
       [self setIsAlertViewActive:NO];
       if (compBlock)compBlock(YES);
    };
    //[alert showError:CURRENT_VIEWCONTROLLER title:LOCALIZATION(C_NETWORK_ERROR) subTitle:message closeButtonTitle:LOCALIZATION(C_REG_BTN_OK) duration:0.0f];
    [self setIsAlertViewActive:YES];
}

- (void)showErrorAlertWithMessage:(NSString *)message
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    //[alert showError:CURRENT_VIEWCONTROLLER title:LOCALIZATION(C_REG_MSG_ERROR) subTitle:message closeButtonTitle:LOCALIZATION(C_REG_BTN_OK) duration:0.0f];
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    //[alert showError:CURRENT_VIEWCONTROLLER title:title subTitle:message closeButtonTitle:LOCALIZATION(C_REG_BTN_OK) duration:0.0f];
}

- (void)showWebserviceAlertWithAlert:(WebserviceAlert *)webServiceAlert onCompletion:(CompletionBlock)compBlock
{
    if ([self checkIfAlertExists])return;
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
    alert.dismissBlock = ^{
        if (compBlock)compBlock(YES);
    };
    [alert showError:CURRENT_VIEWCONTROLLER title:webServiceAlert.title subTitle:webServiceAlert.message closeButtonTitle:webServiceAlert.btnTextPositive duration:0.0f];
}

- (void)showNotificationAlertWithMessage:(NSString *)message onCompletion:(CompletionBlock)compBlock
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    SCLButton *button = [alert addButton:@"Show Now" actionBlock:^(void) {
        if (compBlock)compBlock(YES);
    }];
    
    button.layer.borderWidth = 2.0f;
    
    button.buttonFormatBlock = ^NSDictionary* (void)
    {
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
        
        buttonConfig[@"backgroundColor"] = [UIColor whiteColor];
        buttonConfig[@"textColor"] = APPSECONDARYCOLOR;
        buttonConfig[@"borderColor"] = APPSECONDARYCOLOR;
        
        return buttonConfig;
    };
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:kSound, [[NSBundle mainBundle] resourcePath]]];
    
    [alert showInfo:CURRENT_VIEWCONTROLLER title:@"New Notification" subTitle:message closeButtonTitle:@"Cancel" duration:0.0f];
}


- (void)showWebserviceSuccessWithAlert:(WebserviceAlert *)webServiceAlert onCompletion:(CompletionBlock)compBlock
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
    alert.dismissBlock = ^{
        if (compBlock)compBlock(YES);
    };
    [alert showSuccess:CURRENT_VIEWCONTROLLER title:webServiceAlert.title subTitle:webServiceAlert.message closeButtonTitle:webServiceAlert.btnTextPositive duration:0.0f];
}

- (void)showSuccessWithAlert:(NSString *)message onCompletion:(CompletionBlock)compBlock
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
    alert.dismissBlock = ^{
        if (compBlock)compBlock(YES);
    };
    [alert showSuccess:CURRENT_VIEWCONTROLLER title:@"Success" subTitle:message closeButtonTitle:@"Ok" duration:0.0f];
}

- (void)showBannerAlertWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle
{
//    MGFashionMenuView *alertAddCart = [[MGFashionMenuView alloc] initWithMenuView: [BannerAlert createAlertView:title withColor:FLUOROYELLOWCOLOR :subTitle withColor:[UIColor whiteColor] andWidth:SCREEN_WIDTH]];
//    
//    alertAddCart.frame = CGRectMake(0, 64, alertAddCart.frame.size.width, alertAddCart.frame.size.height);
//    [CURRENT_VIEWCONTROLLER.view addSubview:alertAddCart];
//    [BannerAlert showAlertViewAndFade:alertAddCart];
}

- (BOOL)checkIfAlertExists
{
    UIView *view = CURRENT_VIEW;
    
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[SCLAlertView class]])
        {
           return YES;
        }
    }

    return NO;
}


@end
