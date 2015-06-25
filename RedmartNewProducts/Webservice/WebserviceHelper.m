//
//  WebserviceHelper.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 11/12/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import "WebserviceHelper.h"
#import "DataManager.h"
#import "Session.h"


@implementation WebserviceHelper


#pragma mark - Make request header

//+ (NSDictionary *)prepRequestHeader
//{
//    AppInfo *appInfo = [[AppInfo alloc]init];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:SECRET_TOKEN_VALUE forKey:SECRET_TOKEN_KEY];
//    [dict setObject:CONTENT_TYPE_JSON forKey:CONTENT_TYPE_KEY];
//    [dict setObject:USER_TOKEN forKey:AUTH_TOKEN_KEY];
//    NSLOG(MEMBER_PROGRAM_ID);
//    if (MEMBER_PROGRAM_ID == nil) {
//        [dict setObject:BLANK forKey:PROGRAM_ID];
//    }
//    else [dict setObject:MEMBER_PROGRAM_ID forKey:PROGRAM_ID];
//    
//    NSNumber *languageCode = [appInfo localisedLanguage];
//    [dict setObject:languageCode forKey:APP_LANGUAGE_CODE];
//    
//    return dict;
//}
//
//+ (NSMutableURLRequest *)prepSecureHeaderForRequest:(NSMutableURLRequest *)request
//{
//    AppInfo *appInfo = [[AppInfo alloc]init];
//    NSNumber *languageCode = [appInfo localisedLanguage];
//    [request setValue:[languageCode stringValue] forHTTPHeaderField:APP_LANGUAGE_CODE];
//    [request setValue:CONTENT_TYPE_JSON forHTTPHeaderField:CONTENT_TYPE_KEY];
//    [request setValue:USER_TOKEN forHTTPHeaderField:AUTH_TOKEN_KEY];
//    [request setValue:SECRET_TOKEN_VALUE forHTTPHeaderField:SECRET_TOKEN_KEY];
//    [request setValue:MEMBER_PROGRAM_ID forHTTPHeaderField:PROGRAM_ID];
//    return request;
//}
//
//+ (NSDictionary *)prepPreLoginRequestHeader
//{
//    AppInfo *appInfo = [[AppInfo alloc]init];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:SECRET_TOKEN_VALUE forKey:SECRET_TOKEN_KEY];
//    [dict setObject:CONTENT_TYPE_JSON forKey:CONTENT_TYPE_KEY];
//    
//    NSNumber *languageCode = [appInfo localisedLanguage];
//    [dict setObject:languageCode forKey:APP_LANGUAGE_CODE];
//    return dict;
//}
//
//+ (NSDictionary *)prepImageUploadRequestHeader
//{
//    AppInfo *appInfo = [[AppInfo alloc]init];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:SECRET_TOKEN_VALUE forKey:SECRET_TOKEN_KEY];
//    [dict setObject:USER_TOKEN forKey:AUTH_TOKEN_KEY];
//    
//    NSNumber *languageCode = [appInfo localisedLanguage];
//    [dict setObject:languageCode forKey:APP_LANGUAGE_CODE];
//    
//    return dict;
//}
//
//#pragma mark - Make session check parameters
//+ (NSMutableDictionary *)prepSessionCheckParams:(NSString *)sessionToken
//
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:sessionToken forKey:kSessionToken];
//    return dict;
//}
//
//#pragma mark - Make login parameters
//+ (NSMutableDictionary *)prepLoginParams:(LoginInfo *)loginInfo
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:loginInfo.credentials.loginName forKey:kLoginName];
//    [dict setObject:loginInfo.credentials.loginPassword forKey:kPassword];
//    [dict setObject:loginInfo.deviceInfo.deviceUUID forKey:kDeviceUUID];
//    [dict setObject:loginInfo.deviceInfo.devicePlatform forKey:kDevicePlatform];
//    [dict setObject:[NSString stringWithFormat:@"Hardware- Model-%@ OSVersion-%@",loginInfo.deviceInfo.deviceModel,loginInfo.deviceInfo.iOSVersion]  forKey:kDeviceInformation];
//    [dict setObject:loginInfo.deviceInfo.deviceType forKey:kDeviceType];
//    [dict setObject:loginInfo.appInfo.appVersion forKey:kAppVersion];
//    [dict setObject:loginInfo.pushNotificationInfo.pushToken forKey:kPushToken];
//    return dict;
//}
//
//#pragma mark - Make registration parameters
//
//+ (NSDictionary *)prepRegistrationParams:(UserInfo *)userInfo
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    dict = [self prepLoginParams:userInfo.loginInfo];
//    [dict removeObjectForKey:kAppVersion];
//    [dict setObject:userInfo.firstName forKey:kFirstName];
//    [dict setObject:userInfo.lastName forKey:kLastName];
//    [dict setObject:userInfo.emailAddress forKey:kEmailAddress];
//    [dict setObject:userInfo.outletCode forKey:kOutletCode];
//    [dict setObject:userInfo.contactNumber forKey:kMobileNumber];
//    
//    return dict;
//}
//
//#pragma mark - Make FORGOT password parameters
//
//+ (NSDictionary *)prepForgotPasswordParams:(NSDictionary *)info
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:[info objectForKey:@"Email"] forKey:kEmailAddress];
//    [dict setObject:[info objectForKey:@"UserID"] forKey:kLoginName];
//    return dict;
//}
//
//#pragma mark - Make Brand Details parameters
//
//+ (NSDictionary *)prepBrandDetailsParams:(int)brandID
//{
//  NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:[NSNumber numberWithInt:brandID] forKey:kBrandID];
//    return dict;
//}
//
//+ (NSDictionary *)prepBrandItemDetailsParams:(int)brandItemID
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:[NSNumber numberWithInt:brandItemID] forKey:kBrandItemID];
//    return dict;
//}
//
//#pragma mark - Make Price Summary parameters
//
//+ (NSDictionary *)prepPriceSummaryParams:(NSString *)items
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:items forKey:kSKUList];
//    return dict;
//}
//
//#pragma mark - Make MyPoints parameters
//+ (NSDictionary *)prepTransactionHistoryParams:(MonthTransaction *)transaction andType:(int)type
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    NSString *transactionType = [[NSString alloc]init];
//    switch (type) {
//        case kEarned:
//            transactionType = @"earn";
//            break;
//        case kRedeemed:
//            transactionType = @"redeem";
//            break;
//        default:
//            break;
//    }
//    [dict setObject:transactionType forKey:kTransactionType];
//    [dict setObject:transaction.fromDate forKey:kFromDate];
//    [dict setObject:transaction.toDate forKey:kToDate];
//    return dict;
//}
//
//+ (NSDictionary *)prepMonthTransactionHistoryParams:(int)type
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    NSString *transactionType = [[NSString alloc]init];
//    switch (type) {
//        case kEarned:
//            transactionType = @"earn";
//            break;
//        case kRedeemed:
//            transactionType = @"redeem";
//            break;
//        default:
//            break;
//    }
//    [dict setObject:transactionType forKey:kTransactionType];
//    return dict;
//}
//
//#pragma mark - Make update push notification status parameters
//
//+ (NSDictionary *)prepUpdatePushNotificationsParams:(BOOL)status
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    // dict = [self prepLoginParams:userInfo.loginInfo];
//    [dict setObject:GET_PUSHTOKEN forKey:kPushToken];
//    [dict setObject:[NSNumber numberWithBool:status] forKey:kPushStatus];
//    
//    return dict;
//}
//
//#pragma mark - Make update device info parameters
//
//+ (NSDictionary *)prepUpdateDeviceInfoParams:(DeviceInfo *)info
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:info.pushToken forKey:kPushToken];
//    [dict setObject:info.devicePlatform forKey:kDevicePlatform];
//    [dict setObject:info.deviceType forKey:kDeviceType];
//    [dict setObject:[NSString stringWithFormat:@"Hardware- Model- %@ OSVersion- %@", info.deviceModel,info.iOSVersion] forKey:kDeviceInformation];
//    [dict setObject:info.deviceUUID forKey:kDeviceUUID];
//    return dict;
//}
//
//#pragma mark - Make update profile parameters
//
//+ (NSDictionary *)prepUpdateProfileParams:(UserInfo *)userInfo
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    // dict = [self prepLoginParams:userInfo.loginInfo];
//    [dict setObject:userInfo.firstName forKey:kFirstName];
//    [dict setObject:userInfo.lastName forKey:kLastName];
//    [dict setObject:userInfo.emailAddress forKey:kEmailAddress];
//    [dict setObject:userInfo.contactNumber forKey:kMobileNumber];
//    [dict setObject:userInfo.gender forKey:kGender];
//    [dict setObject:userInfo.race forKey:kRace];
//    [dict setObject:userInfo.address forKey:kAddress];
//    [dict setObject:userInfo.dateOfBirth forKey:kDateOfBirth];
//    
//    return dict;
//}
//
//#pragma mark - Make change Password parameters
//
//+ (NSDictionary *)prepChangePasswordParams:(UserCredentials *)userCredentials
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:userCredentials.loginPassword forKey:kOldPassword];
//    [dict setObject:userCredentials.changedPassword forKey:kChangedPassword];
//    
//    return dict;
//}
//
//#pragma mark - Make change Profile Pic parameters
//+ (NSDictionary *)prepProfilePicUpdateParams:(NSString *)encodedstring
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:encodedstring forKey:kUpdateProfilePic];
//    return dict;
//}
//
//+ (NSDictionary *)prepImageUploadParams:(int)type
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:[NSString stringWithFormat:@"%i",type] forKey:@"Type"];
//    return dict;
//    
//}
//
//+ (NSArray *)prepImageUploadFormDataParams:(NSData *)data
//{
//    NSMutableArray *dataFiles = [NSMutableArray array];
//    [dataFiles addObject:data];
//    
//    return  dataFiles;
//}
//
//+ (NSDictionary *)prepMyPurchasesInMonthParams:(MonthPurchasedItem *)info
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:info.fromDate forKey:kFromDate];
//    [dict setObject:info.toDate forKey:kToDate];
//    
//    return dict;
//}
//
//+ (NSDictionary *)prepMyPurchasesInDayParams:(DayPurchasedItem *)info
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:info.fromDate forKey:kFromDate];
//    [dict setObject:info.toDate forKey:kToDate];
//    
//    return dict;
//}
//
//+ (NSArray *)prepNewMailFormDataParams:(Mail *)mail
//{
//    NSMutableArray *formDataArray = [NSMutableArray array];
//    FormDataItem *mailSubject = [[FormDataItem alloc]init];
//    mailSubject.key = kSubject;
//    mailSubject.data = [mail.subject dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailSubject];
//    
//    FormDataItem *mailMessage = [[FormDataItem alloc]init];
//    mailMessage.key = kContent;
//    mailMessage.data = [mail.message dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailMessage];
//    
//    FormDataItem *mailType = [[FormDataItem alloc]init];
//    mailType.key = kMailRequestType;
//    mailType.data = [kMailCompose dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailType];
//    
//    return formDataArray;
//}
//
//+ (NSArray *)prepNewMailDataFilesParams:(Mail *)mail
//{
//    NSArray *dataArray = [NSArray array];
//    dataArray = mail.attachments;
//    NSMutableArray *dataFiles = [NSMutableArray array];
//    for (MenuItem *attachment in dataArray) {
//        NSData *data = UIImageJPEGRepresentation([mDataManager loadImageWithFileName:attachment.icon],0.75f);
//        [dataFiles addObject:data];
//    }
//    
//    return dataFiles;
//}
//
//+ (NSArray *)prepInboxListFormDataParams
//{
//    NSMutableArray *formDataArray = [NSMutableArray array];
//    
//    FormDataItem *mailType = [[FormDataItem alloc]init];
//    mailType.key = kMailRequestType;
//    mailType.data = [kMailList dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailType];
//    
//    return formDataArray;
//}
//
//+ (NSArray *)prepMailThreadFormDataParamsWithID:(NSString *)mailthreadID
//{
//    NSMutableArray *formDataArray = [NSMutableArray array];
//    
//    FormDataItem *mailType = [[FormDataItem alloc]init];
//    mailType.key = kMailRequestType;
//    mailType.data = [kMailRead dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailType];
//    
//    FormDataItem *mailID = [[FormDataItem alloc]init];
//    mailID.key = kMailID;
//    mailID.data = [mailthreadID dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailID];
//    
//    return formDataArray;
//}
//
//+ (NSArray *)prepReplyMailFormDataParams:(Mail *)mail
//{
//    NSMutableArray *formDataArray = [NSMutableArray array];
//    FormDataItem *mailID = [[FormDataItem alloc]init];
//    mailID.key = kMailID;
//    mailID.data = [mail.mailThreadID dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailID];
//    
//    FormDataItem *mailMessage = [[FormDataItem alloc]init];
//    mailMessage.key = kContent;
//    mailMessage.data = [mail.message dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailMessage];
//    
//    FormDataItem *mailType = [[FormDataItem alloc]init];
//    mailType.key = kMailRequestType;
//    mailType.data = [kMailReply dataUsingEncoding:NSUTF8StringEncoding];
//    [formDataArray addObject:mailType];
//    
//    return formDataArray;
//}
//
//#pragma mark - Make reward details parameters
//
//+ (NSDictionary *)prepRewardDetailsParams:(Reward *)reward
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:reward.itemCode forKey:kItemCode];
//    [dict setObject:reward.categoryCode forKey:kCategoryCode];
//    
//    return dict;
//}
//
//#pragma mark - Make reward catalogue parameters
//
//+ (NSDictionary *)prepRewardsCatalogueParams:(NSDictionary *)data
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:[data objectForKey:@"CurrentPage"] forKey:kCurrentPage];
//    [dict setObject:[data objectForKey:@"CategoryCode"] forKey:kCategoryCode];
//    
//    return dict;
//}
//
//#pragma mark - Make Wishlist Add parameters
//
//+ (NSDictionary *)prepAddtoWishlistParams:(NSDictionary *)data
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:[data objectForKey:@"ItemCode"] forKey:kItemCode];
//    [dict setObject:[data objectForKey:@"CategoryCode"] forKey:kCategoryCode];
//    
//    return dict;
//}
//
//#pragma mark - Make Wishlist Remove parameters
//
//+ (NSDictionary *)prepRemoveFromWishlistParams:(NSDictionary *)data
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:[data objectForKey:@"WishID"] forKey:kWishID];
//    return dict;
//}
//
//#pragma mark - Make Checkout parameters
//
//+ (NSDictionary *)prepCheckoutParams:(NSArray *)data
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    NSMutableArray *array = [NSMutableArray array];
//    for (RewardItem *rewardItem in data) {
//        NSMutableDictionary *rewardInfo = [NSMutableDictionary dictionary];
//        [rewardInfo setObject:[NSString stringWithFormat:@"%d",rewardItem.quantity] forKey:kQuantity];
//        [rewardInfo setObject:rewardItem.reward.itemCode forKey:kItemCode];
//        [array addObject:rewardInfo];
//    }
//    [dict setObject:array forKey:kRedemptionCart];
//    return dict;
//}
//
//+ (NSDictionary *)prepConfirmOrderParams:(NSDictionary *)data
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    NSArray *checkedOutItems = [data objectForKey:@"items"];
//    NSString *remarks = [data objectForKey:@"remarks"];
//    NSMutableArray *array = [NSMutableArray array];
//    for (RewardItem *rewardItem in checkedOutItems) {
//        NSMutableDictionary *rewardInfo = [NSMutableDictionary dictionary];
//        [rewardInfo setObject:[NSString stringWithFormat:@"%d",rewardItem.quantity] forKey:kQuantity];
//        [rewardInfo setObject:rewardItem.reward.itemCode forKey:kItemCode];
//        [array addObject:rewardInfo];
//    }
//    [dict setObject:array forKey:kRedemptionCart];
//    [dict setObject:remarks forKey:kRemarks];
//    return dict;
//}
//
//#pragma mark - Make QRCODE scan parameters
//   
//+ (NSDictionary *)prepQRCodeScanParams:(NSString *)string
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:string forKey:kQRCode];
//    return dict;
//}
//
//+ (NSDictionary *)prepQRCodeScanViewParams:(NSString *)string
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:string forKey:kQRScanID];
//    return dict;
//}
//
//#pragma mark - Make update profile parameters
//
//+ (NSDictionary *)prepNewsFeedDetailsParamsWithID:(NSString *)newsID;
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:newsID forKey:kNewsID];
//    return dict;
//}
//
//#pragma mark - Make Exception error log parameters
//
//+ (NSDictionary *)prepExceptionErrorLogParams:(UncaughtExceptionHandler *)exceptionInfo
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:exceptionInfo.logHelper.deviceInfo.devicePlatform forKey:kDevicePlatform];
//    [dict setObject:exceptionInfo.logHelper.currentModule forKey:kModule];
//    [dict setObject:exceptionInfo.logHelper.deviceInfo.deviceUUID forKey:kDeviceUUID];
//    [dict setObject:exceptionInfo.logHelper.deviceInfo.deviceType forKey:kDeviceType];
//    [dict setObject:exceptionInfo.logHelper.appInfo.appVersion forKey:kAppVersion];
//    [dict setObject:[NSString stringWithFormat:@"Hardware- Model- %@ OSVersion- %@", exceptionInfo.logHelper.deviceInfo.deviceModel, exceptionInfo.logHelper.deviceInfo.iOSVersion]forKey:kDeviceInformation];
//    [dict setObject:exceptionInfo.errorDescription forKey:kErrorDesc];
//    return dict;
//}

@end
