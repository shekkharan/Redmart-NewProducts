//
//  AlertViewManager.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 30/12/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCLAlertView.h"
#import "BannerAlert.h"
#import "WebServiceResponse.h"


#define mAlert	((AlertViewManager *) [AlertViewManager getInstance])
typedef void (^CompletionBlock)(BOOL);

@interface AlertViewManager : NSObject

+ (AlertViewManager*) getInstance;

@property(nonatomic,assign)BOOL isAlertViewActive;
- (void)showLogoutAlert:(CompletionBlock)compBlock;
- (void)showNetworkErrorAlert:(NSString *)message onCompletion:(CompletionBlock)compBlock;
- (void)showErrorAlertWithMessage:(NSString *)message;
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)showWebserviceAlertWithAlert:(WebserviceAlert *)webServiceAlert onCompletion:(CompletionBlock)compBlock;
- (void)showWebserviceSuccessWithAlert:(WebserviceAlert *)webServiceAlert onCompletion:(CompletionBlock)compBlock;
- (void)showNotificationAlertWithMessage:(NSString *)message onCompletion:(CompletionBlock)compBlock;
- (void)showSuccessWithAlert:(NSString *)message onCompletion:(CompletionBlock)compBlock;
- (void)showBannerAlertWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle;

@end
