//
//  ProductDetailsCell.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 3/2/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "ProductDetailsCell.h"
#import "Headers.h"
#import "UIImageView+AFNetworking.h"
#import "ImageViewer.h"


@implementation ProductDetailsCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (ProductDetailsCell *)loadCarouselCell
{
    ProductDetailsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailsCell" owner:nil options:nil] objectAtIndex:0];
    return cell;
}

+ (ProductDetailsCell *)loadProductDetailsCell
{
    ProductDetailsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailsCell" owner:nil options:nil] objectAtIndex:1];
    return cell;
}

#pragma mark - iCarousel delegates and datasource

-(void) initCarousel:(iCarousel *)carousel
{
    carousel.type = iCarouselTypeLinear;
    carousel.stopAtItemBoundary= YES;
    carousel.decelerationRate = 0.5;
    carousel.bounces = YES;
    carousel.scrollSpeed = 0.8f;
    carousel.contentView.userInteractionEnabled = YES;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    if ([self.product.detailsImages count] == 1) {
        self.carImages.scrollEnabled = NO;
    }
    return [self.product.detailsImages count];
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIView *vwCarousel = [[UIView alloc]initWithFrame:carousel.frame];
    vwCarousel.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    [img setImageWithURLAF:[NSURL URLWithString:[self.product.detailsImages objectAtIndex:index]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.center = vwCarousel.center;
    [vwCarousel addSubview:img];
    
    
    if (index == carousel.currentItemIndex) {
        self.superVC.imgView = img;
        [self.superVC.imagesArray replaceObjectAtIndex:index withObject:img.image];
    }
    
    return vwCarousel;
}

- (BOOL)carousel:(iCarousel *)carousel shouldSelectItemAtIndex:(NSInteger)index
{
    return YES;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(showImageViewerWithImageURL: andIndex:)]) {
        [self.delegate showImageViewerWithImageURL:[self.product.detailsImages objectAtIndex:index] andIndex:index];
    }
   
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return [self.product.detailsImages count];
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 320;
}

- (void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel
{
    self.pcImages.currentPage = self.carImages.currentItemIndex;
    if ([self.delegate respondsToSelector:@selector(updateImageatIndex:)]) {
        [self.delegate updateImageatIndex:self.carImages.currentItemIndex];
    }
    
}

- (void)flipCarousel
{
    [self.carImages scrollByNumberOfItems:1 duration:0.5];
}

- (void)pageControlPageDidChange:(PageControl *)pc
{
    [self.carImages scrollToItemAtIndex:pc.currentPage animated:YES];
}

- (void)setData:(Product *)product
{
    self.lblDescription.text = product.desc;
    self.lblPrice.text = product.price;
    self.lblProductName.text = product.name;
    self.lblQuantity.text = product.quantity;
    if (self.product.isOnSale == kYes) {
        self.lblPromoPrice.text = self.product.promoPrice;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.lblPrice.text];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@1
                                range:NSMakeRange(0, [attributeString length])];
        self.lblPrice.attributedText = attributeString;
    }
    else self.lblPromoPrice.text = BLANK;
    [self.lblPromoPrice sizeToFit];
}

@end
