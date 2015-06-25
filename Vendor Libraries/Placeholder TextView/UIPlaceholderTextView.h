//
//  UIPLaceholderTextView.h
//  CAGSweetConnect
//
//  Created by Shekhar on 6/3/13.
//  Copyright (c) 2013 thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIPlaceholderTextView : UITextView {
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;

}

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;


- (void)textEditBegan:(NSNotification *)notification;
-(void)textChanged:(NSNotification*)notification;

@end
