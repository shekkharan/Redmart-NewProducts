//
//  DataManager.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 10/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <UIKit/UIKit.h>
#import "AlertViewManager.h"

@class Reachability;


#define mDataManager	((DataManager *) [DataManager getInstance])

@interface DataManager : NSObject
{
}

@property(nonatomic)BOOL isUserDataChanged;

+ (DataManager *)getInstance;

- (void)saveFirstPageofProducts:(NSArray *)data;
- (NSArray *)loadFirstPageofProducts;

@end
