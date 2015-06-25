//
//  Product.h
//  RedmartNewProducts
//
//  Created by Shekhar on 5/22/14.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kNo = 0,
    kYes =  1
}YesNo;

@interface Product : NSObject<NSCoding>

@property (strong, nonatomic) NSString *productID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSMutableArray *detailsImages;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *promoPrice;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *quantity;
@property (strong, nonatomic) NSString *promoText;
@property (strong, nonatomic) NSString *savingsText;
@property (assign, nonatomic) YesNo isNew;
@property (assign, nonatomic) YesNo isInStock;
@property (assign, nonatomic) YesNo isOnSale;

- (id)initWithData:(NSDictionary *)data;

@end



