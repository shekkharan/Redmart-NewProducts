//
//  WebserviceManager.m
//  RedmartNewProducts
//
//  Created by Shekhar on 20/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import "WebServiceManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "UpdateHUD.h"
#import "AppDelegate.h"
#import "Session.h"
#import "Reachability.h"
#import "AlertViewManager.h"

static NSString *kForbiddenAccess = @"Request failed: not found (404)";
static WebServiceManager *webServiceManagerInstance;

@interface WebServiceManager()
{
    
    Reachability *internetReach;
}
@end

@implementation WebServiceManager

@synthesize delegate=_delegate;
@synthesize requestURL;
@synthesize requestHeaders;
@synthesize requestParams;
@synthesize mutableRequest;
@synthesize serviceReference;
@synthesize imageUploadPath;
@synthesize imageInfoDict;
@synthesize imageData;
@synthesize requestBody;
@synthesize methodType;
@synthesize manager;
@synthesize isReachable;

+ (WebServiceManager *)sharedInstance
{
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        webServiceManagerInstance = [[WebServiceManager alloc] init];
    });
    
    return webServiceManagerInstance;
}

- (id) init {
    if (self = [super init])
    {
        manager = [AFHTTPRequestOperationManager manager];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged) name:kReachabilityChangedNotification object:nil];
        
        // Internet Reachability
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            NSLog(@"Reachability changed: %@", AFStringFromNetworkReachabilityStatus(status));
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    // -- Reachable -- //
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    // -- Not reachable -- //
                    [mAlert showNetworkErrorAlert:@"Please check your internet connection" onCompletion:nil];
                    break;
            }
            
        }];

        return self;
    }
    return nil;
}

#pragma mark API connectors

- (void)executeURLRequest
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:mutableRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [UpdateHUD removeMBProgress:self.activeView];
         //[self successRequest:responseObject request:request withServiceIndentifier:self.serviceReference];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         
         //[self failedRequest:error request:request withServiceIndentifier:self.serviceReference];
         
         NSLog(@"%@", [error description]);
     }];
    
    [operation start];
}

#pragma mark - Download Image AFNetwork API

- (void)downloadImage
{
    AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:self.mutableRequest];
    postOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //[self successRequest:responseObject request:request withServiceIndentifier:self.serviceReference];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //[self failedRequest:error request:request withServiceIndentifier:self.serviceReference];
     }];
    
    [postOperation start];
}

#pragma mark - Upload Image AFNetwork API

- (void)doProcesswithRequest:(WebServiceRequest *)request
{
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    if (request.vwHUD != nil) {
        [UpdateHUD addMBProgress:request.vwHUD withText:request.msgHUD];
    }
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    if (request.requestHeaders) {
        
        for (int i =0;i < [request.requestHeaders count];i++) {
            [manager.requestSerializer setValue:[[request.requestHeaders allValues]objectAtIndex:i] forHTTPHeaderField:[[request.requestHeaders allKeys]objectAtIndex:i]];
        }
    }
    [manager setSecurityPolicy:securityPolicy];
    
    if (request.requestMethod == POST)
    {
        [manager POST:request.requestURL parameters:request.requestParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (request.vwHUD != nil) {
                [UpdateHUD removeSpotifyHUD:request.vwHUD];
                
            }
            [self successRequest:responseObject request:request withServiceIndentifier:[NSNumber numberWithInt:request.webserviceCall]];
        }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  if (request.vwHUD != nil) {
                      [UpdateHUD removeMBProgress:request.vwHUD];                  }
                  [self failedRequest:error request:request withServiceIndentifier:[NSNumber numberWithInt:request.webserviceCall]];
              }];
    }
    
    else if (request.requestMethod == GET)
    {
        [manager GET:request.requestURL parameters:request.requestParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self successRequest:responseObject request:request withServiceIndentifier:[NSNumber numberWithInt:request.webserviceCall]];
            }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
            {
                [self failedRequest:error request:request withServiceIndentifier:[NSNumber numberWithInt:request.webserviceCall]];
            }];
    }
}

#pragma mark - Upload Image AFNetwork API



#pragma mark - Response Methods

- (void)successRequest:(id)responseObj request:(WebServiceRequest*)request withServiceIndentifier:(NSNumber *)reference
{
    NSLog(@"Success%@ %@ %@",request.requestHeaders, request.requestURL, request.requestParams);
    [self processSucceeded:responseObj :reference :request];
}


- (void) failedRequest:(NSError *)error request:(WebServiceRequest*)request withServiceIndentifier:(NSNumber *)reference
{
    NSLog(@"Failure%@ %@ %@",request.requestHeaders, request.requestURL, request.requestParams);
    [self processFail:error :reference :request];
}

- (NSString *)urlEncodeUsingEncoding:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
}

#pragma mark-
#pragma mark API call

#pragma mark - Session Check

- (void)getNewProductsListWithParameters:(ListQueryParameters *)parameter onView:(UIView *)view withDelegate:(id <WebServiceManagerDelegate> )delegate
{
    WebServiceRequest *request = [[WebServiceRequest alloc] init];
    [request setRequestURL:[self urlEncodeUsingEncoding:[NSString stringWithFormat:@"%@%@%@%@?%@%@&%@%@&%@%@&%@%@",SERVER_PREFIX,SERVER_VERSION,PRODUCTS_PREFIX,PRODUCTS_CATEGORY_PREFIX,PAGE,parameter.page,PAGESIZE,parameter.pageSize,SORT,parameter.sort,INSTOCK,parameter.instock]]];
    [request setRequestMethod:GET];
    [request setWebserviceCall:kGETNEWPRODUCTSLIST];
    [request setVwHUD:view];
    [request setMsgHUD:LOADING_HUD];
    [request setDelegate:delegate];
    [self doProcesswithRequest:request];
}

- (void)getProductDetailsWithID:(NSString *)productID onView:(UIView *)view withDelegate:(id <WebServiceManagerDelegate> )delegate
{
    WebServiceRequest *request = [[WebServiceRequest alloc] init];
    [request setRequestURL:[self urlEncodeUsingEncoding:[NSString stringWithFormat:@"%@%@%@%@",SERVER_PREFIX,SERVER_VERSION,PRODUCTS_PREFIX,productID]]];
    [request setRequestMethod:GET];
    [request setWebserviceCall:kGETPRODUCTDETAILS];
    [request setVwHUD:view];
    [request setMsgHUD:LOADING_HUD];
    [request setDelegate:delegate];
    [self doProcesswithRequest:request];

}

#pragma mark - Setter method

- (void)setWSMDelegate:(id <WebServiceManagerDelegate> )delegate
{
    self.delegate = delegate;
}

#pragma mark - Cancel current operations

- (void)cancelCurrentOperations
{
    //  cancel all of them!
    [manager.operationQueue cancelAllOperations];
    [UpdateHUD removeMBProgress:CURRENT_VIEW];
}

#pragma mark - Check if internet is reachable
-(BOOL) isInternetReachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

#pragma mark-
#pragma mark response call backs
- (void)processSucceeded:(id)object :(NSNumber *)ref :(WebServiceRequest *)request {
    WebServiceResponse *response = [[WebServiceResponse alloc] initWithData:object];
    response.webserviceCall = [ref intValue];
    
    if ([request.delegate respondsToSelector:@selector(processCompleted:)]) {
        
        [request.delegate performSelector:@selector(processCompleted:) withObject:response];
    }
}

- (void)processFail:(NSError *)error :(NSNumber *)ref :(WebServiceRequest *)request{
    WebServiceResponse *response = [[WebServiceResponse alloc] init];
    response.error = error;
    response.webserviceCall = [ref intValue];
    
    if ([request.delegate respondsToSelector:@selector(processFailed:)])
    {
        [request.delegate performSelector:@selector(processFailed:) withObject:response];
    }
}

@end