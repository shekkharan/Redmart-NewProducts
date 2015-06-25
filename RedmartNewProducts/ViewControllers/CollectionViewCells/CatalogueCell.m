//
//  CatalogueCell.m
//  iRedmart
//
//  Created by Shekhar  on 23/8/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
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

}

@end
