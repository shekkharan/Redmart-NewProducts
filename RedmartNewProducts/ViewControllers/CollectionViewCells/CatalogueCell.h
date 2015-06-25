//
//  CatalogueCell.h
//  iRedmart
//
//  Created by Shekhar  on 23/8/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CatalogueCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblItemName;
@property (strong, nonatomic) IBOutlet UIImageView *imgItem;
@property (weak, nonatomic) IBOutlet UIView *vwInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lblOverlay;
@property (weak, nonatomic) IBOutlet UILabel *lblPromoPrice;

+ (CatalogueCell *)loadCatalogueCell;

@end
