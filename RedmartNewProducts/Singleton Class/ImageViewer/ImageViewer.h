//
//  ImageViewer.h
//  RedmartNewProducts
//
//  Created by Shekhar  on 5/3/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "BaseVC.h"

#define mImageViewer	((ImageViewer *) [ImageViewer getInstance])

#define MAIN_LABEL_Y_ORIGIN 0
#define IMAGEVIEW_Y_ORIGIN 15

@interface ImageViewer : UIViewController

@property (readwrite, nonatomic) int yOrigin;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *url;

+ (ImageViewer*) getInstance;
- (void)showImageViewer:(UIViewController *)vc withImage:(NSString *)image andURL:(NSString *)urlStr;
- (void)setImageWithName:(NSString *)image andURL:(NSString *)urlStr;

@end
