//
//  TransitionFromDetailsToImgViewer.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 26/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "TransitionFromDetailsToImgViewer.h"
#import "ProductDetailsVC.h"
#import "ImageViewer.h"
#import "Helper.h"

@implementation TransitionFromDetailsToImgViewer

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ProductDetailsVC *fromViewController = (ProductDetailsVC*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ImageViewer *toViewController = (ImageViewer*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Get a snapshot of the thing cell we're transitioning from
   // CatalogueCell *cell = (CatalogueCell*)[fromViewController.cvProducts cellForItemAtIndexPath:[[fromViewController.cvProducts indexPathsForSelectedItems] firstObject]];
    UIView *cellImageSnapshot = [fromViewController.imgView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:fromViewController.imgView.frame fromView:fromViewController.imgView.superview];
    fromViewController.imgView.hidden = YES;
    
    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.imgImageViewer.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:0.4f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        // Fade in the second view controller's view
        toViewController.view.alpha = 1.0;
        
        // Move the cell snapshot so it's over the second view controller's image view
        CGRect frame = [containerView convertRect:CGRectMake(10, 64, 300, 300)  fromView:toViewController.view];
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        // Clean up
        toViewController.imgImageViewer.hidden = NO;
        fromViewController.imgView.hidden = NO;
        [toViewController.view bringSubviewToFront:toViewController.imgImageViewer];
        [cellImageSnapshot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
