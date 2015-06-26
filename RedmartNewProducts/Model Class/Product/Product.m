//
//  Product.m
//  RedmartNewProducts
//
//  Created by Shekhar on 7/22/14.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "Product.h"
#import "WebServiceRequest.h"

@implementation Product

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if(self)
    {
        self.productID = [[data objectForKey:@"id"]stringValue];
        NSString *strname = [data objectForKey:@"title"];
        self.name = [strname stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceCharacterSet]];
        self.imageURL = [NSString stringWithFormat:@"%@%@",MEDIA_PREFIX,[[data objectForKey:@"img"]objectForKey:@"name"]];
        NSArray *images = [data objectForKey:@"images"];
        self.detailsImages = [NSMutableArray array];
        for (NSDictionary *dict in images) {
            [self.detailsImages addObject:[NSString stringWithFormat:@"%@%@",MEDIA_PREFIX,[dict objectForKey:@"name"]]];
        }
        self.price = [NSString stringWithFormat:@"$%.2f",[[[data objectForKey:@"pricing"]objectForKey:@"price"]doubleValue]];
        self.promoPrice = [NSString stringWithFormat:@"$%.2f",[[[data objectForKey:@"pricing"]objectForKey:@"promo_price"]doubleValue]];
        self.desc = [data objectForKey:@"desc"];
        self.quantity = [[data objectForKey:@"measure"]objectForKey:@"wt_or_vol"];
        
        if ([[data objectForKey:@"promotions"] count] != 0) {
            self.promoText = [[[data objectForKey:@"promotions"]objectAtIndex:0] objectForKey:@"savings_text"];
            
        }
        if ([[data objectForKey:@"pricing"] count] != 0) {
            self.savingsText = [[data objectForKey:@"pricing"]objectForKey:@"savings_text"];
        }
        self.isNew = (YesNo)[[[data objectForKey:@"details"]objectForKey:@"is_new"]intValue];
        self.isInStock = (YesNo)[[[data objectForKey:@"inventory"]objectForKey:@"stock_status"]intValue];
        self.isOnSale = (YesNo)[[[data objectForKey:@"pricing"]objectForKey:@"on_sale"]intValue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    
    if (self = [super init]) {
        self.productID = [decoder decodeObjectForKey:@"id"];
        self.name = [decoder decodeObjectForKey:@"title"];
        self.imageURL = [decoder decodeObjectForKey:@"imageurl"];;
        self.detailsImages = [decoder decodeObjectForKey:@"images"];
        self.promoPrice = [decoder decodeObjectForKey:@"promoprice"];
        self.price = [decoder decodeObjectForKey:@"price"];
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.quantity = [decoder decodeObjectForKey:@"wt_or_vol"];
        self.promoText = [decoder decodeObjectForKey:@"promo_label"];
        self.savingsText = [decoder decodeObjectForKey:@"savings_text"];
        self.isNew = (YesNo)[decoder decodeIntForKey:@"is_new"];
        self.isInStock = (YesNo)[decoder decodeIntForKey:@"stock_status"];
        self.isOnSale = (YesNo)[decoder decodeIntForKey:@"sale"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.productID forKey:@"id"];
    [encoder encodeObject:self.name forKey:@"title"];
    [encoder encodeObject:self.imageURL forKey:@"imageurl"];;
    [encoder encodeObject:self.detailsImages forKey:@"images"];
    [encoder encodeObject:self.promoPrice forKey:@"promoprice"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeObject:self.desc forKey:@"desc"];
    [encoder encodeObject:self.quantity forKey:@"wt_or_vol"];
    [encoder encodeObject:self.promoText forKey:@"promo_label"];
    [encoder encodeObject:self.savingsText forKey:@"savings_text"];
    [encoder encodeInt:self.isNew forKey:@"is_new"];
    [encoder encodeInt:self.isInStock forKey:@"stock_status"];
    [encoder encodeInt:self.isOnSale forKey:@"sale"];
}

- (Product *)copyFromProduct:(Product *)copyFrom
{
    self.productID = copyFrom.productID;
    self.name = copyFrom.name;
    self.imageURL = copyFrom.imageURL;
    self.detailsImages = copyFrom.detailsImages;
    self.price = copyFrom.price;
    self.promoPrice = copyFrom.promoPrice;
    self.desc = copyFrom.desc;
    self.quantity = copyFrom.quantity;
    self.promoText = copyFrom.promoText;
    self.savingsText = copyFrom.savingsText;
    self.isNew = copyFrom.isNew;
    self.isInStock = copyFrom.isInStock;
    self.isOnSale = copyFrom.isOnSale;
    return self;
}

@end