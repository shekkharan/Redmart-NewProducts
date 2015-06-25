//
//  Session.m
//  RedmartNewProducts
//
//  Created by Shekhar on 16/12/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import "Session.h"
#import "UIFlowManager.h"
#import "FileManager.h"
#import "DataManager.h"
#import "Constants.h"

static Session* instance;

@interface Session()<WebServiceManagerDelegate>
{
    dispatch_queue_t cacheClear;
}

@end

@implementation Session

@synthesize hasUserChanged;


#pragma mark -
#pragma mark INIT

- (id) init {
	if (self = [super init])
	{
        cacheClear = dispatch_queue_create("bgclearcache", NULL);
        return self;
	}
    return nil;
}

+ (Session*) getInstance {
	@synchronized([Session class]) {
        
		if ( instance == nil ) {
			instance = [[Session alloc] init];
		}
	}
	return instance;
}

#pragma mark -
#pragma mark UI Controls



#pragma mark -
#pragma mark Reset App Data

- (void)reset
{
    [FileManager emptySandbox];
    [FileManager removeFile:USER_PROFILE_ARCHIVE_NAME];
    BOOL remembermeOption = [[NSUserDefaults standardUserDefaults] boolForKey:REMEMBER_ME];
    if (!remembermeOption)
    {
    }
    
    SET_AUTHENTICATIONTOKEN(BLANK);
    SET_PROGRAM_ID(BLANK);
}

//#pragma mark -
//#pragma mark Webservice delegates
//- (void)processCompleted:(WebServiceResponse *)response
//{
//    [UpdateHUD addSpotifyHUDSplash:CURRENT_VIEW];
//    
//    if (response.webserviceCall == kSESSIONCHECK)
//    {
//        if (!response.errorInResponse) {
//            self.userInfo = [mDataManager loadUserProfile];
//            [mFlowManager performSelector:@selector(loadHomeScreen) withObject:nil afterDelay:3.0];
//        }
//        else
//        {
//            [FileManager removeFile:USER_PROFILE_ARCHIVE_NAME];
//            [mFlowManager loadLogin];
//        }
//    }
//}
//
//- (void)processFailed:(WebServiceResponse *)response
//{
//    if (response.webserviceCall == kSESSIONCHECK)
//    {
//        [mFlowManager loadLogin];
//    }
//}

@end
