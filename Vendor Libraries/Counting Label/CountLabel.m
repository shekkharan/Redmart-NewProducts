//
//  CountLabel.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 9/1/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "CountLabel.h"

@implementation CountLabel

- (id)initWithLabel:(UICountingLabel *)label andCount:(NSString *)count
{
    self = [super init];
    
    //if (!self) {
        self.label = label;
        self.count = count;
   // }
    
    return self;
}

@end
