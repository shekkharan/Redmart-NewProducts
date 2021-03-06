//
//  DSLTransitionFromSecondToFirst.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "TransitionFromDetailstoList.h"

#import "ProductsCatalogueVC.h"
#import "ProductDetailsVC.h"
#import "CatalogueCell.h"

@implementation TransitionFromDetailstoList

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ProductDetailsVC *fromViewController = (ProductDetailsVC*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ProductsCatalogueVC *toViewController = (ProductsCatalogueVC*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    fromViewController.imgView.image = [fromViewController.imagesArray objectAtIndex:0];
    // Get a snapshot of the image view
    UIView *imageSnapshot = [fromViewController.imgView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:fromViewController.imgView.frame fromView:fromViewController.table.superview];
    fromViewController.table.hidden = YES;

    // Get the cell we'll animate to
    CatalogueCell *cell = [toViewController collectionViewCellForProduct:fromViewController.product];
    cell.imgItem.hidden = YES;

    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView addSubview:imageSnapshot];

    [UIView animateWithDuration:duration animations:^{
        // Fade out the source view controller
        fromViewController.view.alpha = 0.0;

        // Move the image view
        imageSnapshot.frame = [containerView convertRect:cell.imgItem.frame fromView:cell.imgItem.superview];
    } completion:^(BOOL finished) {
        // Clean up
        [imageSnapshot removeFromSuperview];
        fromViewController.table.hidden = NO;
        cell.imgItem.hidden = NO;

        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
