//
//  TableViewWithEmptyView.m
//
//
//  Created by Shekhar on 8/31/14.
//  Copyright 2014 Redmart. All rights reserved.
//

#import "TableViewWithEmptyView.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation TableViewWithEmptyView

@synthesize emptyView;

- (bool) tableViewHasRows
{
    // TODO: This only supports the first section so far
    return [self numberOfRowsInSection:0] == 0;
}

- (void) updateEmptyPage
{
    const CGRect rect = (CGRect){CGPointZero,self.frame.size};
    emptyView.frame  = rect;
    
    switch (emptyView.viewType) {
        case kFull:
        {
            emptyView.lblPlaceholderTitle.frame = CGRectMake(10, emptyView.center.y, 300, 30);
        }
            break;
            
        case kPartial:
        {
           emptyView.lblPlaceholderTitle.frame = CGRectMake(0, emptyView.center.y, 300, 30);
        }
            break;
            
        case kRewards:
        {
            emptyView.lblPlaceholderTitle.frame = CGRectMake(-10, emptyView.center.y, 300, 30);
        }
            break;
            
        default:
            break;
    }
    
    const bool shouldShowEmptyView = self.tableViewHasRows;
    const bool emptyViewShown      = emptyView.superview != nil;

    if (shouldShowEmptyView == emptyViewShown) return;

    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionFade];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[self layer] addAnimation:animation forKey:kCATransitionReveal];

    if (shouldShowEmptyView)
        [self addSubview:emptyView];
    else
        [emptyView removeFromSuperview];
}

- (void) setEmptyView:(PlaceholderView *)newView
{
    if (newView == emptyView) return;

    UIView *oldView = emptyView;
    emptyView = [newView retain];

    [oldView removeFromSuperview];
    [oldView release];

    [self updateEmptyPage];
}

#pragma mark UIView

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self updateEmptyPage];
}

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // Prevent any interaction when the empty view is shown
    const bool emptyViewShown = emptyView.superview != nil;
    return emptyViewShown ? nil : [super hitTest:point withEvent:event];
}

#pragma mark UITableView

- (void) reloadData
{
    [self updateEmptyPage];
    [super reloadData];
}

@end
