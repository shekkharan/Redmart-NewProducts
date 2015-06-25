//
//  CatalogueCell.h
//  iEdenred
//
//  Created by Shekhar  on 23/8/14.
//  Copyright (c) 2014 Edenred. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CatalogueCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblItemName;
@property (strong, nonatomic) IBOutlet UIImageView *imgItem;
@property (weak, nonatomic) IBOutlet UIView *vwInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToCart;


@property (weak, nonatomic) IBOutlet UIButton *btnAddToWishlist;
@property (weak, nonatomic) IBOutlet UILabel *lblPointsRequired;
@property (weak, nonatomic) IBOutlet UILabel *lblYouRequire;
@property (weak, nonatomic) IBOutlet UILabel *lblOverlayText;

+ (CatalogueCell *)loadCatalogueCell;

@end
