//
//  UIButton+withData.m
//  ManpowerManagement
//
//  Created by Shekhar  on 21/1/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import "UIButton+withData.h"

static void * LaserUnicornPropertyKey = &LaserUnicornPropertyKey;

@implementation UIButton (withData)
@dynamic btnData;

- (NSString *)btnData {
    return objc_getAssociatedObject(self, LaserUnicornPropertyKey);
}

- (void)setBtnData:(NSString *)btnData {
    objc_setAssociatedObject(self, LaserUnicornPropertyKey, btnData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
