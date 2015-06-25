//
//  WebserviceManager.h
//  RedmartNewProducts
//
//  Created by Shekhar on 20/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UpdateHUD.h"
#import "Constants.h"
#import "WebServiceManager.h"
#import "WebServiceResponse.h"
#import "WebServiceRequest.h"
#import "WebserviceHelper.h"

@class WebServiceManager;

typedef void (^FinishBlock)(BOOL);

#define mWebServiceManager	((WebServiceManager *) [WebServiceManager sharedInstance])

typedef enum {
    kProfilePicUpload         = 1,
    kMailAttachment           = 2
} ImageUploadType;

@protocol WebServiceManagerDelegate <NSObject>

@optional

- (void)webserviceManager:(WebServiceManager *)aManager processedData: (WebServiceResponse *) aResponse;
- (void)webserviceManager:(WebServiceManager *)aManager processFailed:(WebServiceResponse *) aResponse;
- (void)processCompleted:(WebServiceResponse *)response;
- (void)processFailed:(WebServiceResponse *)response;
- (void)processCompletedWithNetworkTime:(long long)networkTime;
- (void)processCompletedUploadCSV;

@end

@interface WebServiceManager : NSObject
{
}

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic,strong) NSString  *requestURL;
@property (nonatomic,strong) NSDictionary  *requestHeaders;
@property (nonatomic,strong) NSDictionary  *requestParams;
@property (nonatomic,strong) NSMutableURLRequest *mutableRequest;
@property (nonatomic,strong) NSNumber *serviceReference;
@property (nonatomic,strong) NSString *imageUploadPath;
@property (nonatomic,strong) NSDictionary *imageInfoDict;
@property (nonatomic,strong) NSData *imageData;
@property (nonatomic,strong) NSString *requestBody;
@property (nonatomic,assign) RequestMethod methodType;
@property (nonatomic,strong) UIView *activeView;
@property (nonatomic,strong) NSString *msgHUD;
@property (nonatomic, assign) BOOL isReachable;

- (void)downloadImage;
- (void)executeURLRequest;

- (void)cancelCurrentOperations;

- (void)processSucceeded:(id)object :(NSNumber *)ref;
- (void)processFail:(NSError *)error :(NSNumber *)ref;

- (void)successRequest:(id)responseObj request:(WebServiceRequest*)request withServiceIndentifier:(NSNumber *)reference;
- (void)failedRequest:(NSError *)error request:(WebServiceRequest*)request withServiceIndentifier:(NSNumber *)reference;
+ (WebServiceManager *)sharedInstance;

@property (nonatomic,weak) NSObject  <WebServiceManagerDelegate>  *delegate;

//Webservice Calls

//Products
- (void)getNewProductsListWithParameters:(ListQueryParameters *)parameter onView:(UIView *)view withDelegate:(id <WebServiceManagerDelegate> )delegate;
- (void)getProductDetailsWithID:(NSString *)productID onView:(UIView *)view withDelegate:(id <WebServiceManagerDelegate> )delegate;

@end
