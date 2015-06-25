//
//  ImageViewer.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 5/3/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import "ImageViewer.h"
#import "DoActionSheet+Style.h"
#import "UIImageView+AFNetworking.h"
#import "Headers.h"

static ImageViewer *instance;

@interface ImageViewer ()


@property (weak, nonatomic) IBOutlet UIImageView *imgImageViewer;
@property (weak, nonatomic) IBOutlet UIView *vwFunctions;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation ImageViewer

+ (ImageViewer*) getInstance {
    @synchronized([ImageViewer class]) {
        if ( instance == nil ) {
            instance = [[ImageViewer alloc] init];
        }
    }
    return instance;
}

- (void)setImageWithName:(NSString *)image andURL:(NSString *)urlStr
{
    if (urlStr.length > 0) {
        [self.imgImageViewer setImageWithURLAF:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    }
    //else self.imgImageViewer.image = [mDataManager loadImageWithFileName:image];
    
    self.imgImageViewer.contentMode = UIViewContentModeScaleAspectFit;
    [self animateImage];
    
}

- (void)animateImage{
    
   self.imgImageViewer.frame = CGRectMake(15, self.yOrigin + IMAGEVIEW_Y_ORIGIN, 40, 40);
    
    self.vwFunctions.alpha = 0;
    self.vwFunctions.frame = CGRectMake(self.vwFunctions.frame.origin.x, self.vwFunctions.frame.size.height + self.view.frame.size.height, self.vwFunctions.frame.size.width, self.vwFunctions.frame.size.height);
    //apply animation on ENTERING INTO THE VIEW
    [UIView animateWithDuration:0.4f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
        
         NSLog(@"width %f height %f",self.imgImageViewer.frame.size.width,self.imgImageViewer.frame.size.height);
         
         self.imgImageViewer.frame = CGRectMake(100, 50, 300, 400);
         
         self.vwFunctions.frame = CGRectMake(self.vwFunctions.frame.origin.x, self.view.frame.size.height - self.vwFunctions.frame.size.height, self.vwFunctions.frame.size.width, self.vwFunctions.frame.size.height);
         self.vwFunctions.alpha = 1;
     }
                     completion:NULL];
}

#pragma mark -
#pragma mark View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDisplayInfo];
    MASKCORNER(self.imgImageViewer, 3);
    //[self setImageWithName:imageName andURL:url];
}

- (void)getDisplayInfo
{
    [self setImageWithName:self.imageName andURL:self.url];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[Helper hideAllSubviewsinView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    //[Helper showViewWithAnimation:self.imgImageViewer withDuration:0.4];
    //[Helper showViewWithAnimation:self.vwFunctions withDuration:0.4];
    //[Helper showAnimationOnViewWillAppear:self.vwFunctions withDuration:0.4];
}

#pragma mark Implementation

- (void)showImageViewer:(UIViewController *)vc withImage:(NSString *)image andURL:(NSString *)urlStr
{
    [Helper showAnimationOnView:self.navigationController.view withDuration:0.4];
    [vc.navigationController pushViewController:self animated:NO];
    _url = urlStr;
    _imageName = image;
    self.title = image;
    if (self.view) {
        [self setImageWithName:_imageName andURL:_url];
    }
}

- (void)showActionSheetForSavingOptions
{
    DoActionSheet *actionSheet = [[DoActionSheet alloc] init];
    actionSheet.nAnimationType = 2;
    [actionSheet setStyle1];
    actionSheet.dRound = 5;
    actionSheet.dButtonRound = 3;
    actionSheet.nContentMode = DoASContentNone;
    [actionSheet showC:@"Cancel" buttons:@[@"Save Image", @"Copy"] result:^(int nResult) {
        
        switch (nResult)
        {
            case 0:
            {
                UIImageWriteToSavedPhotosAlbum(self.imgImageViewer.image, nil, nil, nil);
                [self performSelector:@selector(showAlertWithMessage:) withObject:@"Image saved in your camera roll" afterDelay:1];
            }
                break;
            case 1:
            {
                [UIPasteboard generalPasteboard].image = self.imgImageViewer.image;
                [self performSelector:@selector(showAlertWithMessage:) withObject:@"Image copied to clipboard" afterDelay:1];
            }
                 break;
            default:
                break;
        }
    }];
}

- (void)showAlertWithMessage:(NSString *)message
{
    WebserviceAlert *alert = [[WebserviceAlert alloc]init];
    alert.title = @"Success";
    alert.message = message;
    alert.btnTextPositive = @"Ok";
    
    [mAlert showWebserviceSuccessWithAlert:alert onCompletion:nil];
}

- (IBAction)btnSaveClicked:(id)sender {
    [self showActionSheetForSavingOptions];
}

//- (IBAction)doneBtnPressed:(id)sender
//{
//    //animation on EXIT FROM CURRENT VIEW
//    [UIView animateWithDuration:0.4f animations:^
//     {
//         self.imgImageViewer.frame = CGRectMake(10, self.yOrigin + IMAGEVIEW_Y_ORIGIN, 40, 40);
//         self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 0-self.doneBtn.frame.size.height-20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
//         self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.textviewForDetail.frame.size.height + self.view.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
//         self.textviewForDetail.alpha = 0;
//         self.backgroundImageView.alpha = 0;
//     }
//                     completion:^(BOOL finished)
//     {
//         [self.navigationController popViewControllerAnimated:NO];
//     }
//     ];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
