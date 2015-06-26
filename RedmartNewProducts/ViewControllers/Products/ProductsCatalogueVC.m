//
//  ProductsCatalogueVC.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 24/06/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "ProductsCatalogueVC.h"
#import "CatalogueCell.h"
#import "ProductDetailsVC.h"
#import "UIImageView+AFNetworking.h"
#import "Product.h"

@interface ProductsCatalogueVC ()<UICollectionViewDelegateFlowLayout>
{
    BOOL lastQueryHadData;
    int nextPageToBeloaded;
    CatalogueCell *_sizingCell;
}

@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@property (strong, nonatomic) IBOutlet UICollectionView *cvProducts;
@property (strong, nonatomic) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceholder;
@property (strong, nonatomic) NSString *currentPage;
@property (nonatomic, assign) CGPoint lastContentOffset;

@end

@implementation ProductsCatalogueVC

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpInterface];
    nextPageToBeloaded = 0;
    [self getDisplayInfo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
    self.title = @"New";
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([self.items count] == 0) {
        self.lblPlaceholder.hidden = NO;
        [Helper showAnimationOnView:self.lblPlaceholder withDuration:0.4];
    }
    else self.lblPlaceholder.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
      [self animateVisibleCells];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}


#pragma mark - Implementation

- (ListQueryParameters *)getListQueryParameters
{
    ListQueryParameters *parameters = [[ListQueryParameters alloc]init];
    parameters.page = [NSString stringWithFormat:@"%d",nextPageToBeloaded];
    parameters.pageSize = @"20";
    parameters.sort = @"null";
    parameters.instock = @"false";
    return parameters;
}

- (void)loadItems
{
    if ([self.items count] == 0) {
        self.lblPlaceholder.text = @"No Data Found";
        self.lblPlaceholder.hidden = NO;
        self.cvProducts.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        MASKCORNER(self.cvProducts,5);
    }
    else
    {
        self.lblPlaceholder.hidden = YES;
        self.cvProducts.backgroundColor = [UIColor clearColor];
    }
    [self.cvProducts reloadData];
}

- (void)getDisplayInfo
{
    self.items = [NSMutableArray array];
    //show first page Cached data while loading new data
    if ([mDataManager loadFirstPageofProducts]) {
        self.items = (NSMutableArray *)[mDataManager loadFirstPageofProducts];
    }
    
    if ([self.items count] == 0) {
        self.lblPlaceholder.text = @"Loading..";
        self.lblPlaceholder.hidden = NO;
        self.cvProducts.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        MASKCORNER(self.cvProducts,5);
    }
    else
    {
        self.lblPlaceholder.hidden = YES;
        self.cvProducts.backgroundColor = [UIColor clearColor];
    }
    [self.cvProducts reloadData];
    [self getProductsCatalogue:[self getListQueryParameters]];
}

- (void)setUpInterface
{
    [self.cvProducts registerNib:[UINib nibWithNibName:@"CatalogueCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.cvProducts setContentSize:CGSizeMake(self.cvProducts.bounds.size.width, self.cvProducts.bounds.size.height)];
    _sizingCell = [[[UINib nibWithNibName:@"CatalogueCell" bundle:nil]instantiateWithOwner:nil options:nil] objectAtIndex:0];
    
    [self.cvProducts selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    //[self prepareVisibleCellsForAnimation];
}

- (void)getProductsCatalogue:(ListQueryParameters *)parameters
{
    [[WebServiceManager sharedInstance] getNewProductsListWithParameters:parameters onView:nil withDelegate:self];
    
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat bottomInset = scrollView.contentInset.bottom;
    CGFloat bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height - bottomInset;
    NSLog(@"%f",scrollView.contentSize.height);
    if (bottomEdge == scrollView.contentSize.height) {
        [UpdateHUD addMBProgress:self.view withText:@"Loading.."];
        if (lastQueryHadData) {
            [self getProductsCatalogue:[self getListQueryParameters]];
        }
    }
}

#pragma mark - Animation of cells

- (void)animateVisibleCells {
    for (int i = 0; i < [self.cvProducts.visibleCells count]; i++) {
        CatalogueCell * cell = (CatalogueCell *) [self.cvProducts cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        if (i%2) {
            cell.frame = CGRectMake(cell.frame.origin.x + cell.frame.size.width + self.view.frame.size.width, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
        }
        else cell.frame = CGRectMake(cell.frame.origin.x - self.view.frame.size.width, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
        cell.alpha = 0.f;
        
        [UIView animateWithDuration:0.25f
                              delay:i * 0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cell.alpha = 1.f;
                             if (i%2) {
                                 cell.frame = CGRectMake(cell.frame.origin.x - self.view.frame.size.width - cell.frame.size.width , cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
                             }
                             else cell.frame = CGRectMake(self.view.frame.size.width + cell.frame.origin.x, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
                         }
                         completion:nil];
    }
}

#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.items count];
}

- (CatalogueCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CatalogueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    Product *product = [self.items objectAtIndex:[indexPath row]];
    
    if (!cell) cell = [CatalogueCell loadCatalogueCell];

    [cell.imgItem setImageWithURLAF:[NSURL URLWithString:product.imageURL] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    cell.imgItem.contentMode = UIViewContentModeScaleAspectFit;
    cell.lblItemName.text = product.name;
    cell.lblQuantity.text = product.quantity;
    
    cell.lblPrice.text = product.price;
  
    if (product.isNew == kYes) {
        cell.lblOverlay.text = @"   NEW   ";
        cell.lblOverlay.backgroundColor = ORANGECOLOR;
    }
    
    if (product.isInStock == kNo) {
        cell.lblOverlay.text = @"   SOLD OUT   ";
        cell.lblOverlay.backgroundColor = [UIColor darkGrayColor];
    }
    
    if (product.promoText.length > 0) {
        cell.lblOverlay.text = [NSString stringWithFormat:@"  %@  ",product.promoText];
        cell.lblOverlay.backgroundColor = SKYBLUECOLOR;
    }
    if (product.savingsText.length > 0) {
        cell.lblOverlay.text = [NSString stringWithFormat:@"  %@  ",product.savingsText];
        cell.lblOverlay.backgroundColor = APPPRIMARYCOLOR;
    }
    [cell.lblOverlay sizeToFit];
    
    if (product.isOnSale == kYes) {
        cell.lblPromoPrice.text = product.promoPrice;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:cell.lblPrice.text];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@1
                                range:NSMakeRange(0, [attributeString length])];
        cell.lblPrice.attributedText = attributeString;
    }
    else cell.lblPromoPrice.text = BLANK;
    [cell.lblPromoPrice sizeToFit];
    MASKCORNER(cell.lblOverlay, 3);
    MASKCORNER(cell, 5);
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat targetWidth = 144;

    Product *product = [self.items objectAtIndex:[indexPath row]];
    [_sizingCell.imgItem setImageWithURLAF:[NSURL URLWithString:product.imageURL] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    _sizingCell.imgItem.contentMode = UIViewContentModeScaleAspectFit;
    _sizingCell.lblItemName.text = product.name;
    _sizingCell.lblQuantity.text = product.quantity;
    _sizingCell.lblPrice.text = product.price;
    [_sizingCell setNeedsUpdateConstraints];
    [_sizingCell updateConstraintsIfNeeded];
    CGSize size = CGSizeMake(targetWidth, 0);
    return [_sizingCell.contentView systemLayoutSizeFittingSize:size];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailsVC *vc = [[ProductDetailsVC alloc]init];
    vc.product = [self.items objectAtIndex:indexPath.row];
    self.title = BLANK;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark WebServiceManager delegate methods

- (void)processCompleted:(WebServiceResponse *)response
{
    [UpdateHUD removeMBProgress:self.view];
    if (response.webserviceCall == kGETNEWPRODUCTSLIST)
    {
        if (!response.errorInResponse) {
            NSArray *productsList = [response getProductsList];
            if (nextPageToBeloaded == 0) {
                [mDataManager saveFirstPageofProducts:productsList];
                //Remove first page Cached data
                self.items = [NSMutableArray array];
            }
            if ([productsList count] > 0) {
                for (NSDictionary *dict in productsList) {
                    NSLOG(dict);
                    Product *product = [[Product alloc]initWithData:dict];
                    [self.items addObject:product];
                }
                
               
                nextPageToBeloaded ++;
                lastQueryHadData = YES;
            }
            else lastQueryHadData = NO;
            [self loadItems];
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
    [UpdateHUD removeMBProgress:self.view];
    [mAlert showNetworkErrorAlert:[response getNetworkFailureMsg] onCompletion:^(BOOL completion){
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
