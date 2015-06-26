//
//  ProductsCatalogueVC.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 24/06/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "BaseVC.h"

@class CatalogueCell;
@class Product;

@interface ProductsCatalogueVC : BaseVC

- (CatalogueCell*)collectionViewCellForProduct:(Product*)product;
@property (strong, nonatomic) IBOutlet UICollectionView *cvProducts;

@end
