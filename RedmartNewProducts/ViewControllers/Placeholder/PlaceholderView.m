//
//  PlaceholderView.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 8/4/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "PlaceholderView.h"
#import "Constants.h"



@implementation PlaceholderView

- (id)initWithView:(UIView *)view
{
    self = [super initWithFrame:view.frame];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PlaceholderView" owner:self options:nil] objectAtIndex:0];
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

@end
