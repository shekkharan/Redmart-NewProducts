//
//  Session.h
//  RedmartNewProducts
//
//  Created by Shekhar on 16/12/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  <UIKit/UIKit.h>
#import "WebServiceManager.h"

#define mSession 	((Session *) [Session getInstance])

@interface Session : NSObject
{
}

@property(nonatomic)BOOL hasUserChanged;
@property(nonatomic)BOOL isSessionActive;
@property(nonatomic, strong)NSString *sessionToken;

+ (Session *)getInstance;

//Session API's
- (void)reset;
- (BOOL)isSessionActive;
- (BOOL)hasUserChanged;

@end
