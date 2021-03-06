//
//  ProductDetailsCell.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 3/2/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"
#import "iCarousel.h"
#import "Product.h"
#import "ProductDetailsVC.h"

@protocol ProductDetailsCellDelegate <NSObject>

- (void)showImageViewerWithImageURL:(NSString *)url andIndex:(NSInteger)index;
- (void)updateImageatIndex:(NSInteger)index;

@end

@interface ProductDetailsCell : UITableViewCell<iCarouselDataSource,iCarouselDelegate,PageControlDelegate>

@property (weak, nonatomic)Product *product;
@property (weak, nonatomic)IBOutlet iCarousel *carImages;
@property (weak, nonatomic)IBOutlet PageControl *pcImages;
@property (weak, nonatomic)IBOutlet UILabel *lblProductName;
@property (weak, nonatomic)IBOutlet UILabel *lblQuantity;
@property (weak, nonatomic)IBOutlet UILabel *lblDescription;
@property (weak, nonatomic)IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblPromoPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblOverLay;
@property (weak, nonatomic) ProductDetailsVC *superVC;
@property (weak, nonatomic) id <ProductDetailsCellDelegate>delegate;

+ (ProductDetailsCell *)loadCarouselCell;
+ (ProductDetailsCell *)loadProductDetailsCell;

- (void)setData:(Product *)product;
-(void) initCarousel:(iCarousel *)carousel;

@end
