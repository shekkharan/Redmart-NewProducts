//
//  DMCustomModalViewController.m
//  DMCustomModalViewController
//
//  Created by Thomas Ricouard on 5/3/13.
//  Copyright (c) 2013 Thomas Ricouard. All rights reserved.
//

#import "DMCustomModalViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

static const CGFloat KZposition = -4000;
static const CGFloat kDeep = 0.80;

@interface DMCustomModalViewController ()

@property (nonatomic, weak) UIViewController *fromViewController;
@property (nonatomic, strong, readwrite) UIView *overlayView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panFullView;
@property (nonatomic, strong) UINavigationBar *contentNavBar;
@property (nonatomic) CGAffineTransform originalTransform;
@property (nonatomic, getter = isPresenting) BOOL presenting;
@property (nonatomic) CGPoint initialPoint;
@property (nonatomic) DMCustomModalViewControllerPresentationStyle currentPresentationStyle;
- (void)onTapGesture;
@end

@implementation DMCustomModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
            parentViewController:(UIViewController *)parentViewController
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                             action:@selector(onPanGesture:)];
        _panFullView = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                              action:@selector(onPanGesture:)];
        _rootViewController = rootViewController;
        _fromViewController = parentViewController;
        _animationSpeed = 0.30;
        _tapParentViewToClose = YES;
        self.allowDragRootView = NO;
        self.allowDragRootViewNavigationBar = YES;
        _allowDragFromBottomToTop = NO;
        _parentViewScaling = kDeep;
        _parentViewYPath = 0.0;
        _rootViewControllerHeight = 400.0;
        _draggedRootViewAlphaValue = 0.80;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.rootViewController willMoveToParentViewController:self];
    [self addChildViewController:self.rootViewController];
    [self.view addSubview:self.rootViewController.view];
    CGRect frame = self.rootViewController.view.frame;
    frame.origin.y = 0;
    [self.rootViewController didMoveToParentViewController:self];
    [self.rootViewController.view setFrame:frame];
    [self.rootViewController.view addGestureRecognizer:self.panFullView];
    [self.rootViewController.view setUserInteractionEnabled:YES];
    for (UIView *view in self.rootViewController.view.subviews) {
        if ([view isKindOfClass:[UINavigationBar class]]) {
            _contentNavBar = (UINavigationBar *)view;
            [self.contentNavBar addGestureRecognizer:self.panGesture];
            [self.panGesture setEnabled:self.isAllowDragRootViewNavigationBar];
            [self.contentNavBar setUserInteractionEnabled:YES];
        }
    }
    
}



- (void)presentRootViewControllerWithPresentationStyle:(DMCustomModalViewControllerPresentationStyle)presentationStyle
                                  controllercompletion:(void (^)(void))completion
{
    [self setCurrentPresentationStyle:presentationStyle];
    [self setModalPresentationStyle:UIModalPresentationCustom];
    [self setTransitioningDelegate:self];
    
    NSLOGFRAME(self.fromViewController.view);
    
    [self.fromViewController presentViewController:self animated:YES completion:^{
        completion();
    }];
}

- (void)dismissRootViewControllerWithCompletion:(void (^)(void))completion
{
    
    if ([self.fromViewController isBeingDismissed]) {
        NSLog(@"avoid");
        return;
    }
    
    [self.fromViewController dismissViewControllerAnimated:YES completion:^{
          completion();
    }];
}

#pragma mark - setter
- (void)setTapParentViewToClose:(BOOL)tapParentViewToClose
{
    _tapParentViewToClose = tapParentViewToClose;
    [self.tapGesture setEnabled:tapParentViewToClose];
}

- (void)setAllowDragRootViewNavigationBar:(BOOL)allowDragRootViewNavigationBar
{
    _allowDragRootViewNavigationBar = allowDragRootViewNavigationBar;
    [self.panGesture setEnabled:allowDragRootViewNavigationBar];
}

- (void)setAllowDragRootView:(BOOL)allowDragRootView
{
    _allowDragRootView = allowDragRootView;
    [self.panFullView setEnabled:allowDragRootView];
}

#pragma mark - gesture
- (void)onTapGesture
{
    [self dismissRootViewControllerWithCompletion:^{
        
    }];
}


-(void)onPanGesture:(UIPanGestureRecognizer *)reconizer
{
    UIView *draggableView = self.rootViewController.view;
    if (reconizer.state == UIGestureRecognizerStateBegan) {
        _initialPoint = draggableView.layer.position;
        [UIView animateWithDuration:0.2 animations:^{
            draggableView.alpha = _draggedRootViewAlphaValue;
        }];
        
    }
    else if (reconizer.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [reconizer translationInView:[draggableView superview]];
        CGPoint newPoint;
        newPoint = CGPointMake([draggableView center].x ,
                               [draggableView center].y + translation.y);
        if (newPoint.y < _initialPoint.y && !self.isAllowDragFromBottomToTop) {
            newPoint = CGPointMake([draggableView center].x ,
                                   [draggableView center].y);
        }
        [draggableView setCenter:newPoint];
        [reconizer setTranslation:CGPointZero inView:[draggableView superview]];
        
    }
    else if (reconizer.state == UIGestureRecognizerStateEnded ||
             reconizer.state == UIGestureRecognizerStateCancelled){
        CGRect frame = draggableView.frame;
        if (frame.origin.y > _rootViewControllerHeight/2) {
            [self dismissRootViewControllerWithCompletion:^{
                draggableView.layer.position = _initialPoint;
                draggableView.alpha = 1.0;
            }];
        }
        else{
            [UIView animateWithDuration:0.2 animations:^{
                draggableView.layer.position = _initialPoint;
                draggableView.alpha = 1.0;
            }];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    _presenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _presenting = NO;
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.animationSpeed;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *primaryView = self.fromViewController.view;
    
    NSLOGFRAME(primaryView);
    
    if (!self.isPresenting) {
        
        primaryView.transform = self.originalTransform;
        
        void (^modifyAngle) (void) = ^{
            CALayer *layer = primaryView.layer;
            layer.zPosition = KZposition;
            CATransform3D rotationAndPerspectiveTransform = layer.transform;
            rotationAndPerspectiveTransform.m34 = 1.0 / 300;
            layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform,
                                                  -3.0f * M_PI / 180.0f,
                                                  1.0f,
                                                  0.0f,
                                                  0.0f);
            
        };
        
        void (^scaleView) (void) = ^{
            [self.overlayView setAlpha:0.0];
            primaryView.transform =  CGAffineTransformScale(primaryView.transform, 1.0, 1.0);
            CGRect frame = primaryView.frame;
            frame.origin.y += self.parentViewYPath;
            [primaryView setFrame:frame];
        };
        
        void (^animationBlock) (void) = ^{
            [UIView animateWithDuration:duration
                                  delay:0.05
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:modifyAngle
                             completion:^(BOOL finished) {
                                 [UIView animateWithDuration:duration
                                                  animations:scaleView
                                                  completion:^(BOOL finished) {
                                                      if (finished)
                                                          [self.overlayView removeFromSuperview];
                                                      if ([self.delegate respondsToSelector:@selector(customModalViewControllerDidDismiss:)]) {
                                                          [self.delegate customModalViewControllerDidDismiss:self];
                                                      }
                                                      if (_closeCompletionBlock) {
                                                          _closeCompletionBlock();
                                                      }
                                                      [transitionContext completeTransition:YES];
                                                  }];
                             }];
            
        };
        
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = frame.size.height;
            [self.view setFrame:frame];
        }];
        
        animationBlock();
    }
    else{
        
        CGRect frame = self.view.frame;
        frame.origin.y = frame.size.height + 30;
        [self.view setFrame:frame];
        
        void (^modifyAngle) (void) = ^{
            _overlayView = [[UIView alloc]initWithFrame:primaryView.bounds];
            [self.overlayView setBackgroundColor:[UIColor blackColor]];
            [self.overlayView setAlpha:0.0];
            
            //[[transitionContext containerView]addSubview:self.fromViewController.view];
            //[[transitionContext containerView]addSubview:self.overlayView];
            [[transitionContext containerView]addSubview:self.view];
            
            CALayer *layer = primaryView.layer;
            layer.zPosition = KZposition;
            CATransform3D rotationAndPerspectiveTransform = layer.transform;
            rotationAndPerspectiveTransform.m34 = 1.0 / -300;
            layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform,
                                                  2.0f * M_PI / 180.0f,
                                                  1.0f,
                                                  0.0f,
                                                  0.0f);
            
            
            [self.overlayView setAlpha:0.2];
            if (self.isTapParentViewToClose) {
                _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGesture)];
                [self.tapGesture setNumberOfTapsRequired:1],
                [self.overlayView addGestureRecognizer:self.tapGesture];
                [self.overlayView setUserInteractionEnabled:YES];
            }
        };
        
        void (^scaleView) (void) = ^{
            CGAffineTransform xForm = primaryView.transform;
            primaryView.transform = CGAffineTransformScale(xForm, _parentViewScaling, _parentViewScaling);
            CGRect frame = primaryView.frame;
            frame.origin.y -= self.parentViewYPath;
            [primaryView setFrame:frame];
            self.originalTransform = primaryView.transform;
        };
        
        primaryView.window.backgroundColor = [UIColor blackColor];
        [UIView animateWithDuration:duration
                         animations:modifyAngle
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [UIView animateWithDuration:duration
                                                       delay:0.0
                                                     options:UIViewAnimationOptionCurveEaseIn
                                                  animations:scaleView
                                                  completion:NULL];
                                 void (^modalBlock) (void);
                                 
                                 modalBlock = ^{
                                     __block CGRect frame = self.view.frame;
                                     frame.origin.y = frame.size.height - self.rootViewControllerHeight;
                                     if (self.currentPresentationStyle == DMCUstomModalViewControllerPresentFullScreen) {
                                         frame.origin.y = 0;
                                     }
                                     [UIView animateWithDuration:duration animations:^{
                                         
                                         [self.view setFrame:frame];
                                     }completion:^(BOOL finished) {
                                         [transitionContext completeTransition:YES];
                                     }];
                                 };
                                 
                                 dispatch_time_t modalDelay =
                                 dispatch_time(DISPATCH_TIME_NOW, 10000000);
                                 dispatch_after(modalDelay, dispatch_get_main_queue(), modalBlock);
                                 
                             }
                         }];
    }
    
}

@end

@implementation UIViewController (UIViewControllerCustomModalItem)
@dynamic customModalViewController;

- (DMCustomModalViewController *)customModalViewController
{
    if ([self.parentViewController isKindOfClass:[DMCustomModalViewController class]]) {
        return (DMCustomModalViewController *)self.parentViewController;
    }
    if (self.navigationController) {
        if ([self.navigationController.parentViewController isKindOfClass:[DMCustomModalViewController class]]) {
            return (DMCustomModalViewController *)self.navigationController.parentViewController;
        }
    }
    return nil;
}

@end
