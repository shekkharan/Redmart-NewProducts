//
//  WebServiceRequest.h
//  RedmartNewProducts
//
//  Created by Shekhar on 20/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    GET     = 1,
    PUT     = 2,
    POST    = 3,
    DELETE  = 4
}   RequestMethod;

#define SERVER_PREFIX @"https://api.redmart.com/"
#define SERVER_VERSION @"v1.5.4/"
#define PRODUCTS_PREFIX @"products/"
#define PRODUCTS_CATEGORY_PREFIX @"new"
#define MEDIA_PREFIX @"http://media.redmart.com/newmedia/200p"
#define PAGE @"page="
#define PAGESIZE @"pageSize="
#define SORT @"sort="
#define INSTOCK @"instock="

typedef enum {
    kGETNEWPRODUCTSLIST             = 1,
    kGETPRODUCTDETAILS              = 2,
}   WebserviceCall;


@interface WebServiceRequest : NSObject

@property (nonatomic,strong)NSString  *webserviceAPI;
@property (nonatomic,strong)NSString  *msgHUD;
@property (nonatomic,strong)UIView  *vwHUD;
@property (nonatomic,strong)NSString  *requestURL;
@property (nonatomic,strong)NSDictionary *requestHeaders;
@property (nonatomic,strong)NSDictionary *requestParams;
@property (nonatomic,strong)NSString *savedFileName;
@property (nonatomic,assign)RequestMethod requestMethod;
@property (nonatomic,assign)WebserviceCall webserviceCall;
@property (nonatomic,strong)NSString *requestBody;
@property (assign, nonatomic)id delegate;

@end

@interface ListQueryParameters : NSObject

@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)NSString *pageSize;
@property (nonatomic,strong)NSString *sort;
@property (nonatomic,strong)NSString *instock;

@end