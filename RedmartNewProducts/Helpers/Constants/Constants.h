//
//  constant.h
//  RedmartNewProducts
//
//  Created by Shekhar on 20/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#ifndef RedmartNewProducts_Constants_h
#define RedmartNewProducts_Constants_h

//First Launch
#define kHasLaunchedOnce @"HasLaunchedOnce"
#define FIRSTLAUNCH ![[NSUserDefaults standardUserDefaults] boolForKey:kHasLaunchedOnce]

//UserInfo

typedef enum {
    STARPARTNER         = 1,
    FRINGERETAILERS     = 2
} MemberTier;

static NSString * const MemberTier_toString[] = {
    [STARPARTNER] = @"Tier1",
    [FRINGERETAILERS] = @"Tier2"
};

//LOCALIZATION

static NSString * const kSaveLanguageDefaultKey = @"SaveLanguageDefaultKey";

typedef enum {
    ENGLISH   = 1,
    CHINESE   = 2
} LanguageType;

#define kEnglish @"en"
#define kChinese @"zh-Hans"
#define kDeviceLanguage @"DeviceLanguage"
#define kEnglishLanguage @"English"
#define kChineseLanguage @"华文"

static NSString * const LanguageType_toString[] = {
    [ENGLISH] = kEnglish,
    [CHINESE] = kChinese
    
};

#define kAvailableLanguages [NSArray arrayWithObjects:kDeviceLanguage,kEnglish,kChinese, nil]

#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define CURRENT_VIEWCONTROLLER [[UIApplication sharedApplication] keyWindow].rootViewController
#define CURRENT_VIEW   [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]

//NSUSERDEFAULTS
#define SET_PENDINGAUTONAVIGATION(navigationInfo) [[NSUserDefaults standardUserDefaults]setObject:navigationInfo forKey:@"PENDINGAUTONAVIGATION"]
#define GET_PENDINGAUTONAVIGATION [[NSUserDefaults standardUserDefaults]objectForKey:@"PENDINGAUTONAVIGATION"]
#define SET_PUSHTOKEN(pushtoken) [[NSUserDefaults standardUserDefaults]setObject:pushtoken forKey:@"PUSH_NOTIFICATION_TOKEN"]
#define GET_PUSHTOKEN [[NSUserDefaults standardUserDefaults]objectForKey:@"PUSH_NOTIFICATION_TOKEN"]
#define SET_LOCALIZATION(language) [[NSUserDefaults standardUserDefaults]setObject:language forKey:kSaveLanguageDefaultKey]
#define GET_LOCALIZATION [[NSUserDefaults standardUserDefaults]objectForKey:kSaveLanguageDefaultKey]
#define SET_PUSHNOTIFICATIONENABLED(choice) [[NSUserDefaults standardUserDefaults]setBool:choice forKey:PUSHNOTIFICATION_ENABLED]
#define GET_PUSHNOTIFICATIONENABLED [[NSUserDefaults standardUserDefaults]boolForKey:PUSHNOTIFICATION_ENABLED]
#define SET_AUTHENTICATIONTOKEN(authtoken) [[NSUserDefaults standardUserDefaults]setObject:authtoken forKey:SESSION_TOKEN]
#define SET_PROGRAM_ID(programID)  [[NSUserDefaults standardUserDefaults]setObject:programID forKey:PROGRAM_ID]
#define SET_LOGIN_NAME(loginname)  [[NSUserDefaults standardUserDefaults]setObject:loginname forKey:USER_NAME]

//APP INFO
static NSString *kAppVersion = @"AppVersion";
static NSString *kAppBuild = @"AppBuild";
static NSString *kAppName = @"AppName";
#define REMEMBER_ME_ENABLED [[NSUserDefaults standardUserDefaults] boolForKey:REMEMBER_ME]

//Webservice Response Schema
static NSString *RESPONSE_CODE_NODE = @"ResponseCode";
static NSString *RESPONSE_MESSAGE_NODE = @"ResponseMessage";
static NSString *kAuthToken = @"AuthToken";
static NSString *kError = @"Error";
static NSString *kData = @"Data";
static NSString *kStatus = @"status";
static NSString *kResponseCode = @"code";
static NSString *kProducts= @"products";

//USERINFO WEBSERVICE KEYS
static NSString *kLanguageCode = @"LanguageCode";
static NSString *kLoginName = @"LoginName";
static NSString *kPassword = @"Password";
static NSString *kDeviceUUID = @"DeviceToken";
static NSString *kPushToken = @"PushToken";
static NSString *kPushStatus = @"PushStatus";
static NSString *kDeviceType = @"DeviceType";
static NSString *kEmailAddress = @"EmailAddress";
static NSString *kOutletCode = @"OutletCode";
static NSString *kFirstName = @"FirstName";
static NSString *kLastName = @"LastName";
static NSString *kMobileNumber = @"MobileNumber";
static NSString *kDevicePlatform = @"DevicePlatform";
static NSString *devicePlatform = @"iOS";
static NSString *kDeviceInformation = @"DeviceInformation";
static NSString *kTestOutletCode = @"TEST-ER-001";
static NSString *kLastLogin = @"LastLogin";
static NSString *kRegistrationDate = @"RegistrationDate";
static NSString *kSRIncharge = @"SalesRepID";
static NSString *kProfilePicture = @"ProfilePicture";
static NSString *kIsPrimary = @"IsPrimary";
static NSString *kGender = @"Gender";
static NSString *kRace = @"Race";
static NSString *kArea = @"Area";
static NSString *kOutletName = @"OutletName";
static NSString *kOutletType = @"OutletType";
static NSString *kDateOfBirth = @"DOB";
static NSString *kProgramID = @"ProgramID";
static NSString *kRank = @"Rank";
static NSString *kCustomProgram = @"CustomProgram";
static NSString *kReward = @"Reward";
static NSString *kAddress= @"Location";
static NSString *kProgram = @"Program";

//USERPOINTS
static NSString *kExpiringPoints = @"ExpiringPoints";
static NSString *kEarnedPoints = @"EarnedPoints";
static NSString *kRedeemedPoints = @"RedeemedPoints";
static NSString *kExpiredPoints = @"ExpiredPoints";
static NSString *kPromotionPoints = @"PromotionPoints";
static NSString *kCancelledPoints = @"CancelledPoints";
static NSString *kBalancePoints = @"BalancePoints";

//SETTINGS
static NSString *kCurrentPassword = @"Current Password";
static NSString *kNewPassword = @"New Password";
static NSString *kConfirmNewPassword = @"Confirm New Password";
static NSString *kOldPassword = @"OldPassword";
static NSString *kChangedPassword = @"NewPassword";
static NSString *kUpdateProfilePic = @"ProfilePictureData";
static NSString * const kUserProfileChanged = @"UserProfileChanged";
static NSString * const kIncentiveRewardUpdated = @"IncentiveUpdated";
static NSString * const kHomeFooterUpdated = @"HomeFooterUpdated";

//REGISTRATION

static NSString *kAccountNo = @"Account No";
static NSString *kOutletID = @"Outlet ID";
static NSString *kUserID =  @"User ID";
static NSString *kGivenName = @"Given Name";
static NSString *kSurname = @"Surname";
static NSString *kMobile =  @"Mobile";
static NSString *kEmail = @"Email";
static NSString *kReenterPassword = @"Re-enter Password";

//FEATURED BRANDS
static NSString *kBrandID = @"BrandID";
static NSString *kBrandItemID = @"BrandItemID";

//PRICE SUMMARY
static NSString *kSKUList = @"SKUList";

//POINTS TRANSACTION
static NSString *kTransactionType = @"PointType";

//MY PURCHASES
static NSString *kFromDate = @"FromDate";
static NSString *kToDate = @"ToDate";

//MAILBOX
static NSString *kSubject = @"Subject";
static NSString *kContent = @"Content";
static NSString *kAttachment = @"Attachment";
static NSString *kMailRequestType = @"Type";
static NSString *kMailID = @"MailID";
static NSString *kMailCompose = @"compose";
static NSString *kMailList = @"list";
static NSString *kMailRead = @"read";
static NSString *kMailReply = @"reply";

//NEWSFEED
static NSString *kNewsID = @"NewsID";

//EXCEPTION ERROR
static NSString *kErrorDesc = @"ErrorDesc";
static NSString *kModule = @"Module";

//WEBPAGES
static NSString *kGeneralInfo = @"General Information";
static NSString *kTC = @"Terms and Conditions";
static NSString *kEU = @"EULA";
static NSString *kProgramInfo = @"Program Information";

//Rewards
static NSString *kItemCode = @"ItemCode";
static NSString *kCategoryCode = @"CategoryCode";
static NSString *kCurrentPage = @"CurrentPage";
static NSString *kWishID = @"WishID";
static NSString *kQuantity = @"Quantity";
static NSString *kRedemptionCart = @"RedemptionCart";
static NSString *kRemarks = @"Remarks";

//QRCode
static NSString *kQRCode = @"Code";
static NSString *kQRScanID = @"ScanID";

//SIMULATOR
static NSString *kSimulator = @"Simulator";
#define SIMULATOR_DEVICE_TOKEN @"ECF028C6-BEFB-424B-A4B2-D5A7D7AD6BCC"

//APP AUTHENTICATION
#define CONTENT_TYPE_JSON @"application/json"
#define CONTENT_TYPE_FORMDATA @"multipart/form-data"
#define CONTENT_TYPE_KEY @"Content-Type"
#define AUTH_TOKEN_KEY @"AUTH-TOKEN"
#define SECRET_TOKEN_KEY @"ER-TOKEN"
#define SECRET_TOKEN_VALUE @"JTI-AB5C18BF-1C81-4C90-ACD1-D9D7F4B98697"
#define KEYCHAIN_SERVICE_NAME @"come.keychain.RedmartNewProducts"
#define APP_LANGUAGE_CODE @"LanguageCode"
#define SIMULATOR_PUSHNOTIFICATION_TOKEN @"123456"
static NSString *kSessionToken = @"SessionToken";

//TEXTFIELD VALIDATION RULES
#define REGEX_USER_NAME_LIMIT @"^.{6,30}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{6,30}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{8,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{8,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{8}"
#define REGEX_SHOPID_DEFAULT @"[0-9]{8}"
#define REGEX_SHOPID_LIMIT @"^.{8}$"

//HUD
#define SIGNIN_HUD LOCALIZATION(C_SIGNIN_PLACEHOLDER_MSG)
#define REGISTRATION_HUD LOCALIZATION(C_SUBMITTING_PLACEHOLDER_MSG)
#define UPDATING_HUD LOCALIZATION(C_UPDATING_PLACEHOLDER_MSG)
#define SIGNOUT_HUD @"Signing Out.."
#define AUTHENTICATION_HUD @"Authenticating.."
#define LOADING_HUD @"Loading.."
#define SENDING_HUD @"Sending.."
#define SPLASHSCREEN_HUD @"Splash"
#define MYPOINTS_HUD @"MyPoints"
//userinfo

static NSString *kLoginInfo = @"LoginInfo";
static NSString *kPushNotificationInfo = @"PushNotificationInfo";

static NSString *kPlaceholderProfileimage = @"icons_drawer_myaccount";
static NSString *kPlaceholderimage = @"placeholder";
static NSString *kPlaceholderMailImage = @"ic_mailbox";

#define PUSH_TOKEN @"pushnotificationToken"
#define SESSION_TOKEN @"sessiontoken"
#define USER_PASSWORD @"password"
#define USER_NAME @"loginname"
#define PROGRAM_ID @"ProgramID"
#define REMEMBER_ME @"loginremember"
#define PROFILEPIC_KEY @"ProfilePictureData"
#define ATTACHMENT_KEY @"Attachment"
#define MEMBER_PROGRAM_ID  [[NSUserDefaults standardUserDefaults]objectForKey:PROGRAM_ID]
#define LOGIN_NAME  [[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME]
#define USER_TOKEN [[NSUserDefaults standardUserDefaults]objectForKey:SESSION_TOKEN]
#define LOGIN_PASSWORD  [[mSession getSecureStoreManager] getValueForKey:USER_PASSWORD]

#define OS_DEVICE 1 //iOS
#define SMART_PHONE 1 //SmartPhone
#define TABLET 1 //Tablet

//NSUSERDEFAULTS
#define PUSHNOTIFICATION_ENABLED @"pushNotificationEnabled"
#define USERDEFAULTS_PASSWORD @"password"
#define USERDEFAULTS_LOGINID @"loginid"
#define USERDEFAULTS_LANGUAGETYPE @"languageType"
#define USERDEFAULTS_SESSIONID @"sessionid"
#define USERDEFAULTS_PUSHNOTIFICATION_TOKEN @"pushNotification"
#define FIRSTPAGE_ARCHIVE_NAME @"firstpage"
#define USER_PROFILE_ARCHIVE_NAME @"UserInfo"
#define USER_POINTS_ARCHIVE_NAME @"UserPoints"
#define INCENTIVE_TRIP_ARCHIVE_NAME @"Incentive"
#define HOME_FOOTER_ARCHIVE_NAME @"HomeFooter"
#define EARNED_POINTS_TRANSACTIONS_ARCHIVE_NAME @"EarnedPointsTransactions"
#define REDEEMED_POINTS_TRANSACTIONS_ARCHIVE_NAME @"RedeemedPointsTransactions"
#define POINTS_TRANSACTIONS_SUMMARY_ARCHIVE_NAME @"PointsTransactionsSummary"
#define MYPERFORMANCE_ARCHIVE_NAME @"ProductLaunchActivities"
#define PRODUCT_LAUNCH_ARCHIVE_NAME @"ProductLaunchActivities"
#define AUDIT_COMPLIANCE_ARCHIVE_NAME @"AuditComplianceActivities"
#define NEWSFEED_LIST_ARCHIVE_NAME @"NewsFeedList"
#define FEATURED_BRANDS_LIST_ARCHIVE_NAME @"FeaturedBrands"
#define PRODUCTS_LIST_ARCHIVE_NAME @"ProductsList"
#define INBOX_LIST_ARCHIVE_NAME @"InboxList"
#define FEATUREDREWARDS_LIST_ARCHIVE_NAME @"FeaturedRewardsList"
#define REWARDS_SORT_POINTS_LIST_ARCHIVE_NAME @"SortPointsList"
#define REWARDS_CATEGORY_LIST_ARCHIVE_NAME @"SortCategoriesList"
#define WISHLIST_ARCHIVE_NAME @"WishList"
#define MYPURCHASESBYMONTHS_LIST_ARCHIVE_NAME @"MyPurchases"
#define SURVEYLIST_ARCHIVE_NAME @"SurveyList"
//SQL
#define kDatabaseName @"localDB.db"

//DocumentsPath
#define DOC_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//ALERTVIEW
#define  Alert(TITLE,MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:nil \
cancelButtonTitle:@"OK" \
otherButtonTitles:nil] show]

//GENERAL

#define SYSTEMLANGUAGE [[NSLocale preferredLanguages] objectAtIndex:0]
#define EQUALS(text1,text2) [text1 isEqualToString:text2]
#define BLANK @""

#define NSLOGFRAME(view) NSLog(@"FRAME -- %f,%f,%f,%f",view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
#define NSLOG(id) NSLog(@"%@",id);

//BORDER
#define  BORDER(view,color,width) [view addAllBorderWithColor:color andWidth:width]

//ROUNDCORNER
#define  MASKCORNER(view,rad) [view maskRoundCorners:UIRectCornerAllCorners radius:rad]

#define PLACEHOLDERIMG(image) [UIImage imageNamed:image]
#define SETIMAGE(image) [UIImage imageNamed:image]
#define APPPRIMARYCOLOR [UIColor colorWithRed:247/255.0 green:45/255.0 blue:72/255.0 alpha:1.0]
#define APPSECONDARYCOLOR [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0]
#define APPTERTIARYCOLOR [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0]
#define BGCOLOR [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1.0]
#define WHITECOLOR [UIColor whiteColor]
#define HUDWHITECOLOR [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]
#define LIGHTGRAYCOLOR [UIColor lightGrayColor]
#define LIGHTGRAYCOLORTABLE [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1]
#define DARKGRAYCOLOR [UIColor grayColor]
#define ORANGECOLOR [UIColor colorWithRed:241.0/255.0 green:118.0/255.0 blue:13.0/255.0 alpha:1]
#define SKYBLUECOLOR [UIColor colorWithRed:64.0/255.0 green:180.0/255.0 blue:196.0/255.0 alpha:1]
//FONT
#define FONTBOLD(x) [UIFont fontWithName:@"SourceSansPro-Black" size:x]
#define FONTREGULAR(x) [UIFont fontWithName:@"SourceSansPro-Regular" size:x]
#define FONTHEAVY(x) [UIFont fontWithName:@"SourceSansPro-Semibold" size:x]
#define FONTLIGHT(x) [UIFont fontWithName:@"SourceSansPro-Light" size:x]
#define FONTTHIN(x) [UIFont fontWithName:@"HelveticaNeue-Thin" size:x]
#define FONTITALIC(x) [UIFont italicSystemFontOfSize:x]
#define FONTBOLDITALIC(x) [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:x]
#define FONTBOLDULTRALIGHT(x) [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:x]

// SYSTEM VERSION
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//DEVICE
#define iPHONE6 @"iPhone 6"
#define iPHONE6PLUS @"iPhone 6 Plus"
#define iPHONE6WIDTH 375
#define iPHONE6PLUSWIDTH 414
#define iPHONE5WIDTH 320

#define DEVICE_VERSION_EQUAL_TO(devicewidth,versionwidth) (devicewidth == versionwidth)
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#endif
