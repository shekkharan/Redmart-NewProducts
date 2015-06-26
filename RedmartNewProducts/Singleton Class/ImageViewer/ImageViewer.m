//
//  ImageViewer.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 5/3/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "ImageViewer.h"
#import "DoActionSheet+Style.h"
#import "UIImageView+AFNetworking.h"
#import "Headers.h"
#import "TransitionFromImgViewerToDetails.h"
#import "ProductDetailsVC.h"

static ImageViewer *instance;

@interface ImageViewer ()

@property (weak, nonatomic) IBOutlet UIView *vwFunctions;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation ImageViewer
@synthesize actionSheet;

+ (ImageViewer*) getInstance {
    @synchronized([ImageViewer class]) {
        if ( instance == nil ) {
            instance = [[ImageViewer alloc] init];
        }
    }
    return instance;
}

- (void)setImageWithName:(NSString *)image andURL:(NSString *)urlStr
{
    if (urlStr.length > 0) {
        [self.imgImageViewer setImageWithURLAF:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    }
    //else self.imgImageViewer.image = [mDataManager loadImageWithFileName:image];
    
    self.imgImageViewer.contentMode = UIViewContentModeScaleAspectFit;
    [self animateImage];
    
}

- (void)animateImage{
    self.vwFunctions.alpha = 0;
    self.vwFunctions.frame = CGRectMake(self.vwFunctions.frame.origin.x, self.vwFunctions.frame.size.height + self.view.frame.size.height, self.vwFunctions.frame.size.width, self.vwFunctions.frame.size.height);
    //apply animation on ENTERING INTO THE VIEW
    [UIView animateWithDuration:0.4f
                     animations:^(void)
     {
         self.vwFunctions.frame = CGRectMake(self.vwFunctions.frame.origin.x, self.view.frame.size.height - self.vwFunctions.frame.size.height, self.vwFunctions.frame.size.width, self.vwFunctions.frame.size.height);
         self.vwFunctions.alpha = 1;
     }
                     completion:NULL];
}

#pragma mark -
#pragma mark View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDisplayInfo];
    MASKCORNER(self.imgImageViewer, 3);
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
    //[self setImageWithName:imageName andURL:url];
}

- (void)getDisplayInfo
{
    [self setImageWithName:self.imageName andURL:self.url];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[Helper hideAllSubviewsinView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark Implementation

- (void)showImageViewer:(UIViewController *)vc withImage:(NSString *)image andURL:(NSString *)urlStr
{
    //[Helper showAnimationOnView:self.navigationController.view withDuration:0.4];
    [vc.navigationController pushViewController:self animated:NO];
    _url = urlStr;
    _imageName = image;
    self.title = image;
    if (self.view) {
        [self setImageWithName:_imageName andURL:_url];
    }
}

- (void)showActionSheetForSavingOptions
{
    actionSheet = [[DoActionSheet alloc] init];
    actionSheet.nAnimationType = 2;
    [actionSheet setStyle1];
    actionSheet.dRound = 5;
    actionSheet.dButtonRound = 3;
    actionSheet.nContentMode = DoASContentNone;
    [actionSheet showC:@"Cancel" buttons:@[@"Save Image", @"Copy"] result:^(int nResult) {
        
        switch (nResult)
        {
            case 0:
            {
                UIImageWriteToSavedPhotosAlbum(self.imgImageViewer.image, nil, nil, nil);
                [self performSelector:@selector(showAlertWithMessage:) withObject:@"Image saved in your camera roll" afterDelay:1];
            }
                break;
            case 1:
            {
                [UIPasteboard generalPasteboard].image = self.imgImageViewer.image;
                [self performSelector:@selector(showAlertWithMessage:) withObject:@"Image copied to clipboard" afterDelay:1];
            }
                 break;
            default:
                break;
        }
    }];
}

- (void)showAlertWithMessage:(NSString *)message
{
    WebserviceAlert *alert = [[WebserviceAlert alloc]init];
    alert.title = @"Success";
    alert.message = message;
    alert.btnTextPositive = @"Ok";
    
    [mAlert showWebserviceSuccessWithAlert:alert onCompletion:nil];
}

- (IBAction)btnSaveClicked:(id)sender {
    [self showActionSheetForSavingOptions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLFirstViewController
    if (fromVC == self && [toVC isKindOfClass:[ProductDetailsVC class]]) {
        return [[TransitionFromImgViewerToDetails alloc] init];
    }
  
    else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // Check if this is for our custom transition
    if ([animationController isKindOfClass:[TransitionFromImgViewerToDetails class]]) {
        return self.interactivePopTransition;
    }
    else {
        return nil;
    }
}

#pragma mark UIGestureRecognizer handlers

- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
    
}

@end
