//
//  UIFlowManager.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 10/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define mFlowManager 	((UIFlowManager *) [UIFlowManager getInstance])

@interface UIFlowManager : NSObject

+ (UIFlowManager *)getInstance;

- (void)checkFirstLaunch;
- (void)launchApp;
//UI Flow
- (void)loadProductsCatalogue;
- (void)loadSplash;

@end
