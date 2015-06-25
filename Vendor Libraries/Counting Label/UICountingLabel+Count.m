//
//  UICountingLabel+Count.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 9/1/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "UICountingLabel+Count.h"

@implementation UICountingLabel (Count)

- (void)addCountingAnimationwithNumber:(int)number
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    self.formatBlock = ^NSString* (float value)
    {
        NSString* formatted = [formatter stringFromNumber:@((int)value)];
        return [NSString stringWithFormat:@"%@",formatted];
    };
    self.method = UILabelCountingMethodEaseOut;
    [self countFrom:0 to:number withDuration:0.4];
}


@end
