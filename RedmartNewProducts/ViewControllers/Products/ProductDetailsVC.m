//
//  ProductDetailsVC.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 24/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "ProductDetailsVC.h"
#import "iCarousel.h"
#import "PageControl.h"
#import "Product.h"
#import "Headers.h"
#import "ProductDetailsCell.h"
#import "UIImageView+AFNetworking.h"
#import "ProductsCatalogueVC.h"
#import "TransitionFromDetailstoList.h"
#import "TransitionFromDetailsToImgViewer.h"

@interface ProductDetailsVC ()<UINavigationControllerDelegate,ProductDetailsCellDelegate>
{
}

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (strong, nonatomic) NSMutableDictionary *offscreenCells;

@end

@implementation ProductDetailsVC

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpInterface];
    [self getDisplayInfo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
     self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
    // Stop being the navigation controller's delegate
//    if (self.navigationController.delegate == self) {
//        self.navigationController.delegate = nil;
//    }
}

#pragma mark - Implementation

- (void) animateOnEntry
{
    self.navigationController.navigationBarHidden = YES;
    self.table.alpha = 0;
    self.table.frame = CGRectMake(self.table.frame.origin.x, self.table.frame.size.height + self.view.frame.size.height, self.table.frame.size.width, self.table.frame.size.height);
    [UIView animateWithDuration:0.4f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
         self.table.frame = CGRectMake(self.table.frame.origin.x, self.view.frame.size.height - self.table.frame.size.height, self.table.frame.size.width, self.table.frame.size.height);
         self.table.alpha = 1;
         self.navigationController.navigationBarHidden = NO;
     }
                     completion:NULL];
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.table reloadData];
}

- (void)getDisplayInfo
{
    [[WebServiceManager sharedInstance] getProductDetailsWithID:self.product.productID onView:nil withDelegate:self];
}

- (void)setUpInterface
{
    self.title = self.product.name;
    self.table.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
    //[self animateOnEntry];
}


#pragma mark - tableview datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ProductDetailsCell";
    ProductDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.row == 0)
    {
        if (!cell)
        {
            cell = [ProductDetailsCell loadCarouselCell];
            cell.pcImages.numberOfPages = [self.product.detailsImages count];
            if ([self.product.detailsImages count] < 2) {
                cell.pcImages.hidden = YES;
            }
            else cell.pcImages.hidden = NO;
            cell.product = self.product;
            [cell initCarousel:cell.carImages];
            cell.carImages.dataSource = cell;
            cell.carImages.delegate = cell;
            cell.pcImages.delegate = cell;
            cell.pcImages.dotColorCurrentPage = APPPRIMARYCOLOR;
            cell.pcImages.dotColorOtherPage = [UIColor whiteColor];
            cell.pcImages.currentPage = cell.carImages.currentItemIndex;
            [cell.carImages reloadData];
            if (self.product.isNew == kYes) {
                cell.lblOverLay.text = @"   NEW   ";
                cell.lblOverLay.backgroundColor = ORANGECOLOR;
            }
            
            if (self.product.isInStock == kNo) {
                cell.lblOverLay.text = @"   SOLD OUT   ";
                cell.lblOverLay.backgroundColor = [UIColor darkGrayColor];
            }
            
            if (self.product.promoText.length > 0) {
                cell.lblOverLay.text = [NSString stringWithFormat:@"  %@  ",self.product.promoText];
                cell.lblOverLay.backgroundColor = SKYBLUECOLOR;
            }
            if (self.product.savingsText.length > 0) {
                cell.lblOverLay.text = [NSString stringWithFormat:@"  %@  ",self.product.savingsText];
                cell.lblOverLay.backgroundColor = APPPRIMARYCOLOR;
            }
            [cell.lblOverLay sizeToFit];
            NSLOGFRAME(cell.lblOverLay);
            MASKCORNER(cell.lblOverLay, 3);
            [cell.contentView bringSubviewToFront:cell.lblOverLay];
        }
    }
    else
    {
        if (!cell)
        {
            cell = [ProductDetailsCell loadProductDetailsCell];
            [cell setData:self.product];
        }
    }
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    height += 1;
    
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ProductDetailsCell";
    ProductDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.row == 0)
        {
            if (!cell)
            {
                cell = [ProductDetailsCell loadCarouselCell];
                cell.delegate = self;
                cell.product = self.product;
                cell.pcImages.numberOfPages = [self.product.detailsImages count];
                if ([self.product.detailsImages count] < 2) {
                    cell.pcImages.hidden = YES;
                }
                else cell.pcImages.hidden = NO;
                
                cell.superVC = self;
                [cell initCarousel:cell.carImages];
                cell.carImages.dataSource = cell;
                cell.carImages.delegate = cell;
                cell.pcImages.delegate = cell;
                cell.pcImages.dotColorCurrentPage = APPPRIMARYCOLOR;
                cell.pcImages.dotColorOtherPage = [UIColor whiteColor];
                cell.pcImages.currentPage = cell.carImages.currentItemIndex;
                [cell.carImages reloadData];
                if (self.product.isNew == kYes) {
                    cell.lblOverLay.text = @"  NEW  ";
                    cell.lblOverLay.backgroundColor = ORANGECOLOR;
                }
                
                if (self.product.isInStock == kNo) {
                    cell.lblOverLay.text = @"   SOLD OUT   ";
                    cell.lblOverLay.backgroundColor = [UIColor darkGrayColor];
                }
                
                if (self.product.promoText.length > 0) {
                    cell.lblOverLay.text = [NSString stringWithFormat:@"  %@  ",self.product.promoText];
                    cell.lblOverLay.backgroundColor = SKYBLUECOLOR;
                }
                if (self.product.savingsText.length > 0) {
                    cell.lblOverLay.text = [NSString stringWithFormat:@"  %@  ",self.product.savingsText];
                    cell.lblOverLay.backgroundColor = APPPRIMARYCOLOR;
                }
                [cell.lblOverLay sizeToFit];
              
                //[cell.contentView addSubview:cell.lblOverLay];
                NSLOGFRAME(cell.lblOverLay);
                MASKCORNER(cell.lblOverLay, 3);
                [cell.contentView bringSubviewToFront:cell.lblOverLay];
            }
        }
    else
        {
            if (!cell)
            {
            cell = [ProductDetailsCell loadProductDetailsCell];
            cell.product = self.product;
            [cell setData:self.product];
            }
        }

    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WebServiceManager delegate methods

- (void)showImageViewerWithImageURL:(NSString *)url
{
    ImageViewer *imgviewer = [[ImageViewer alloc]init];
    imgviewer.url = url;
    imgviewer.yOrigin = self.imgView.frame.origin.y;
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:imgviewer animated:YES];
}

#pragma mark WebServiceManager delegate methods

- (void)processCompleted:(WebServiceResponse *)response
{
    if (response.webserviceCall == kGETPRODUCTDETAILS)
    {
        if (!response.errorInResponse) {
            NSLog(@"%@",response.responseData);
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[response.responseData objectForKey:@"product"]];
            self.product = [self.product copyFromProduct:[[Product alloc]initWithData:dict]];
            [self.table reloadData];
            [Helper showAnimationOnView:self.table withDuration:0.2];
        }
        else
        {
            [mAlert showWebserviceAlertWithAlert:response.alert onCompletion:^(BOOL completion){
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }
}

- (void)processFailed:(WebServiceResponse *)response
{
    [mAlert showNetworkErrorAlert:[response getNetworkFailureMsg] onCompletion:^(BOOL completion){
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLFirstViewController
    if (fromVC == self && [toVC isKindOfClass:[ProductsCatalogueVC class]]) {
        return [[TransitionFromDetailstoList alloc] init];
    }
    if (fromVC == self && [toVC isKindOfClass:[ImageViewer class]]) {
        return [[TransitionFromDetailsToImgViewer alloc] init];
    }
    else {
        return nil;
    }
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // Check if this is for our custom transition
    if ([animationController isKindOfClass:[TransitionFromDetailstoList class]]) {
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
