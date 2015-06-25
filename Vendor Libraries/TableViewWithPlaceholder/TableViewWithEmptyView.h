//
//  TableViewWithEmptyView.h
//
//
//  Created by Shekhar on 8/31/14.
//  Copyright 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceholderView.h"

@interface TableViewWithEmptyView : UITableView
{
    PlaceholderView *emptyView;
}

@property (retain,nonatomic) IBOutlet PlaceholderView *emptyView;

@property (nonatomic,readonly) bool tableViewHasRows;

@end
