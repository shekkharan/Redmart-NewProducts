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

@interface ProductDetailsVC ()
{
}

@property (weak, nonatomic) IBOutlet UITableView *table;
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
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
    [self animateOnEntry];
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

- (void)processCompleted:(WebServiceResponse *)response
{
    if (response.webserviceCall == kGETPRODUCTDETAILS)
    {
        if (!response.errorInResponse) {
            NSLog(@"%@",response.responseData);
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[response.responseData objectForKey:@"product"]];
            self.product = [[Product alloc]initWithData:dict];
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
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */

@end