//
//  ProductDetailsVC.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 24/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "BaseVC.h"

@class Product;

@interface ProductDetailsVC : BaseVC

@property (strong, nonatomic) Product *product;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) UIImageView *imgView;


@end
