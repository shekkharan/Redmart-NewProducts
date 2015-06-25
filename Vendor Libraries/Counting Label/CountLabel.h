//
//  CountLabel.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 9/1/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICountingLabel+Count.h"

@interface CountLabel : NSObject

@property(nonatomic,strong) UICountingLabel *label;
@property(nonatomic,strong) NSString* count;

- (id)initWithLabel:(UICountingLabel *)label andCount:(NSString *)count;

@end
