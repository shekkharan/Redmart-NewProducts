//
//  DSLTransitionFromFirstToSecond.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLTransitionFromFirstToSecond.h"

#import "ProductsCatalogueVC.h"
#import "ProductDetailsVC.h"
#import "CatalogueCell.h"


@implementation DSLTransitionFromFirstToSecond

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ProductsCatalogueVC *fromViewController = (ProductsCatalogueVC*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ProductDetailsVC *toViewController = (ProductDetailsVC*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    // Get a snapshot of the thing cell we're transitioning from
    CatalogueCell *cell = (CatalogueCell*)[fromViewController.cvProducts cellForItemAtIndexPath:[[fromViewController.cvProducts indexPathsForSelectedItems] firstObject]];
    UIView *cellImageSnapshot = [cell.imgItem snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:cell.imgItem.frame fromView:cell.imgItem.superview.superview];
    cell.imgItem.hidden = YES;

    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.table.hidden = YES;

    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];

    [UIView animateWithDuration:duration animations:^{
        // Fade in the second view controller's view
        toViewController.view.alpha = 1.0;

        // Move the cell snapshot so it's over the second view controller's image view
        CGRect frame = [containerView convertRect:CGRectMake(100, 40, 120, 120) fromView:toViewController.view];
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        // Clean up
        toViewController.table.hidden = NO;
        cell.hidden = NO;
        [cellImageSnapshot removeFromSuperview];

        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
