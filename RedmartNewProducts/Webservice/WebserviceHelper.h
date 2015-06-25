//
//  WebserviceHelper.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 11/12/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceManager.h"

@interface WebserviceHelper : NSObject

//HEADERS
+ (NSDictionary *)prepRequestHeader;
+ (NSMutableURLRequest *)prepSecureHeaderForRequest:(NSMutableURLRequest *)request;
+ (NSDictionary *)prepPreLoginRequestHeader;
+ (NSDictionary *)prepImageUploadRequestHeader;

////PRE_LOGIN PARAMETERS
//+ (NSMutableDictionary *)prepSessionCheckParams:(NSString *)sessionToken;
//+ (NSMutableDictionary *)prepLoginParams:(LoginInfo *)loginInfo;
//+ (NSDictionary *)prepRegistrationParams:(UserInfo *)userInfo;
//+ (NSDictionary *)prepForgotPasswordParams:(NSDictionary *)info;
//
////FEATURED BRANDS
//+ (NSDictionary *)prepBrandDetailsParams:(int)brandID;
//+ (NSDictionary *)prepBrandItemDetailsParams:(int)brandItemID;
//
////PRICE CALCULATOR
//+ (NSDictionary *)prepPriceSummaryParams:(NSString *)items;
//
////POINTS TRANSACTION
//+ (NSDictionary *)prepTransactionHistoryParams:(MonthTransaction *)transaction andType:(int)type;
//+ (NSDictionary *)prepMonthTransactionHistoryParams:(int)type;
//
////PUSH NOTIFICATION
//+ (NSDictionary *)prepUpdatePushNotificationsParams:(BOOL)status;
//+ (NSDictionary *)prepUpdateDeviceInfoParams:(DeviceInfo *)info;
//
////UPDATE PROFILE
//+ (NSDictionary *)prepUpdateProfileParams:(UserInfo *)userInfo;
//+ (NSDictionary *)prepChangePasswordParams:(UserCredentials *)userCredentials;
//+ (NSDictionary *)prepProfilePicUpdateParams:(NSString *)encodedstring;
//
////PROFILE PIC UPLOAD
//+ (NSDictionary *)prepImageUploadParams:(int)type;
//+ (NSArray *)prepImageUploadFormDataParams:(NSData *)data;
//
////MY PURCHASES
//+ (NSDictionary *)prepMyPurchasesInMonthParams:(MonthPurchasedItem *)info;
//+ (NSDictionary *)prepMyPurchasesInDayParams:(DayPurchasedItem *)info;
//
////MAILBOX
//+ (NSArray *)prepNewMailFormDataParams:(Mail *)mail;
//+ (NSArray *)prepNewMailDataFilesParams:(Mail *)mail;
//
//+ (NSArray *)prepInboxListFormDataParams;
//+ (NSArray *)prepMailThreadFormDataParamsWithID:(NSString *)mailthreadID;
//+ (NSArray *)prepReplyMailFormDataParams:(Mail *)mail;
//
////Rewards
//+ (NSDictionary *)prepRewardDetailsParams:(Reward *)reward;
//+ (NSDictionary *)prepRewardsCatalogueParams:(NSDictionary *)data;
//+ (NSDictionary *)prepAddtoWishlistParams:(NSDictionary *)data;
//+ (NSDictionary *)prepRemoveFromWishlistParams:(NSDictionary *)data;
//+ (NSDictionary *)prepCheckoutParams:(NSArray *)data;
//+ (NSDictionary *)prepConfirmOrderParams:(NSDictionary *)data;
//
////QRCODESCAN
//+ (NSDictionary *)prepQRCodeScanParams:(NSString *)string;
//+ (NSDictionary *)prepQRCodeScanViewParams:(NSString *)string;
//
////NEWSFEED
//+ (NSDictionary *)prepNewsFeedDetailsParamsWithID:(NSString *)newsID;
//
////EXCEPTION ERROR LOG
//+ (NSDictionary *)prepExceptionErrorLogParams:(UncaughtExceptionHandler *)exceptionInfo;

@end
