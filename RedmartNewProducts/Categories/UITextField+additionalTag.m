//
//  UITextField+additionalTag.m
//  ManpowerManagement
//
//  Created by Shekhar  on 27/1/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import "UITextField+additionalTag.h"

static void *PropertyKey = &PropertyKey;

@implementation UITextField (additionalTag)

@dynamic additionalTag;

- (NSString *)additionalTag {
    return objc_getAssociatedObject(self, PropertyKey);
}

- (void)setAdditionalTag:(NSString *)additionalTag {
    objc_setAssociatedObject(self, PropertyKey, additionalTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
