//
//  PlaceholderView.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 8/4/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    kPartial = 0,
    kFull = 1,
    kRewards = 2
}PlaceholderViewType;

@interface PlaceholderView : UIView

@property (strong, nonatomic) IBOutlet UILabel *lblPlaceholderTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPlaceholderSubtitle;
@property (assign, nonatomic) PlaceholderViewType viewType;

- (id)initWithView:(UIView *)view;

@end
