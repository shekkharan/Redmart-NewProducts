//
//  WebServiceResponse.h
//  RedmartNewProducts
//
//  Created by Shekhar on 20/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "WebServiceRequest.h"

typedef enum {
    kJSON = 1,
    KSOAP = 2
}   ResponseType;

typedef enum {
    kSessionTokenExpired = 2015,
    KSessionTokenInvalid = 2016
}   ResponseErrorCode;

static int kSuccessCode = 2000;
static int kAppVersionByPassCode = 5001;

@interface WebserviceAlert : NSObject
{
}
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *btnTextPositive;
@property(nonatomic,strong) NSString *btnTextNegative;

- (id)initWithData:(NSDictionary *)data;

@end

@interface WebServiceResponse : NSObject
{
    BOOL isValidJson;
}

@property(nonatomic,assign) NSInteger responseCode;
@property(nonatomic,strong) id data;
@property(nonatomic,strong) NSDictionary *responseData;
@property(nonatomic,assign) WebserviceCall webserviceCall;
@property(nonatomic,assign) ResponseType responseType;
@property(nonatomic,strong) NSString *responseString;
@property(nonatomic,strong) NSError *error;
@property(nonatomic,strong) WebserviceAlert *alert;

- (NSDictionary *)getJSON;
- (BOOL)errorInResponse;
- (id)initWithData:(id)data;
- (id)getGenericResponse;
- (NSArray *)getProductsList;
- (NSString *) getErrorMessage;
- (int)getResponseCode;
- (NSString *)getResponseMessage;
- (NSString *)getAuthToken;
- (NSString *)getProgramID;
- (NSString *)getNetworkFailureMsg;


@end
