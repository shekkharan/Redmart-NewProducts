//
//  TransitionFromImgViewerToDetails.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 26/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "TransitionFromImgViewerToDetails.h"
#import "ImageViewer.h"
#import "ProductDetailsVC.h"

@implementation TransitionFromImgViewerToDetails

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ImageViewer *fromViewController = (ImageViewer*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ProductDetailsVC *toViewController = (ProductDetailsVC*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Get a snapshot of the image view
    UIView *imageSnapshot = [fromViewController.imgImageViewer snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:fromViewController.imgImageViewer.frame fromView:fromViewController.imgImageViewer.superview];
    fromViewController.imgImageViewer.hidden = YES;
    
    // Get the cell we'll animate to
    //CatalogueCell *cell = [toViewController collectionViewCellForProduct:fromViewController.product];
    toViewController.imgView.hidden = YES;
    
    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView addSubview:imageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        // Fade out the source view controller
        fromViewController.view.alpha = 0.0;
        
        // Move the image view
        imageSnapshot.frame = [containerView convertRect:toViewController.imgView.frame fromView:toViewController.imgView.superview];
    } completion:^(BOOL finished) {
        // Clean up
        [imageSnapshot removeFromSuperview];
        fromViewController.imgImageViewer.hidden = NO;
        toViewController.imgView.hidden = NO;
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
