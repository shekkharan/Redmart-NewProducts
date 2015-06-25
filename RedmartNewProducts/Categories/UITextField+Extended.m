//
//  UITextField+Extended.m
//  ManpowerManagement
//
//  Created by Shekhar  on 29/12/14.
//  Copyright (c) 2014 Myaango. All rights reserved.
//

#import "UITextField+Extended.h"
#import <objc/runtime.h>

static char defaultHashKey;

@implementation UITextField (Extended)

- (UITextField*) nextTextField {
    return objc_getAssociatedObject(self, &defaultHashKey);
}

- (void) setNextTextField:(UITextField *)nextTextField{
    objc_setAssociatedObject(self, &defaultHashKey, nextTextField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end