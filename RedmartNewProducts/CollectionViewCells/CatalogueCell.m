//
//  CatalogueCell.m
//  iEdenred
//
//  Created by Shekhar  on 23/8/14.
//  Copyright (c) 2014 Edenred. All rights reserved.
//

#import "CatalogueCell.h"
#import "Headers.h"
#import "UIButton+Extensions.h"
#import "UIButton+withData.h"

@implementation CatalogueCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CatalogueCell *)loadCatalogueCell
{
    CatalogueCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CatalogueCell" owner:nil options:nil] objectAtIndex:0];
    return cell;
}

-(void)awakeFromNib
{
    [self.btnAddToCart maskRoundCorners:UIRectCornerBottomLeft radius:5];
    [self.btnAddToCart setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.btnAddToCart setHitTestEdgeInsets:UIEdgeInsetsMake(-5, -5, -5, 0)];
    [self.btnAddToWishlist maskRoundCorners:UIRectCornerBottomRight radius:5];
    [self.btnAddToWishlist setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.btnAddToWishlist setHitTestEdgeInsets:UIEdgeInsetsMake(-5, 0, -5, -5)];

}

@end
