//
//  WebServiceResponse.m
//  RedmartNewProducts
//  Created by Shekhar on 20/11/14.
//  Copyright (c) 2014 Redmart. All rights reserved.
//

#import "WebServiceResponse.h"
#import "NSDictionary+JSON.h"
#import "Constants.h"


@implementation WebserviceAlert

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    self.message = [data objectForKey:@"msg"];
    return self;
}

@end

@interface WebServiceResponse()
{
    NSDictionary *jsonDictionary;
}

- (BOOL)isValidJson;

@end

@implementation WebServiceResponse

- (id)initWithData:(id)data
{
    if (self = [super init])
    {
        NSError *error;
        self.data = data;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:self.data options: NSJSONReadingMutableContainers error: &error];
        if (jsonObject)
        {
            isValidJson = YES;
            jsonDictionary =  [[NSDictionary alloc ] initWithDictionary:jsonObject];
            self.alert = [[WebserviceAlert alloc]initWithData:[jsonDictionary objectForKey:kStatus]];
        }
        else
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:[error description] forKey:@"ERROR"];
            [dict setObject:[NSNumber numberWithInt:-1] forKey:@"ResponseCode"];
            jsonDictionary =  [[NSDictionary alloc ] initWithDictionary:dict];
        }
        self.responseData = jsonDictionary;
    }
    return self;
}

- (BOOL)isValidJson
{
    return ([NSJSONSerialization isValidJSONObject:self.data]);
}

- (BOOL)errorInResponse
{
    BOOL error = YES;
    int code = -1;
    if (isValidJson)
    {
        code = [[[jsonDictionary objectForKey:kStatus] objectForKey:kResponseCode]intValue];
        if (code == kSuccessCode) error = NO;
    }
    
    return error;
}

- (NSString *)getErrorMessage {
    
    return [jsonDictionary objectForKey:kError];
}

- (NSArray *) getProductsList{
    
    return [jsonDictionary objectForKey:kProducts];
}

- (NSDictionary *)getJSON
{
    return jsonDictionary;
}

- (int)getResponseCode
{
    int code = -1;
    if (isValidJson)
    {
       code = [[jsonDictionary objectForKey:RESPONSE_CODE_NODE] intValue];
    }
        
    return code;
}

- (NSString *)getAuthToken
{
    NSString *authToken = nil;
    if (isValidJson)
    {
        authToken = [[jsonDictionary objectForKey:kData] objectForKey:kAuthToken];
    }
    
    return authToken;
}

- (NSString *)getProgramID
{
    NSString *programID = nil;
    if (isValidJson)
    {
        programID = [[jsonDictionary objectForKey:kData] objectForKey:kProgramID];
    }
    
    return programID;
}


- (NSString *)getResponseMessage
{
    NSString *message = nil;
    if (isValidJson)
    {
        message = [[jsonDictionary objectForKey:RESPONSE_MESSAGE_NODE] objectForKey:@"Message"];
    }
    
    return message;
}

- (NSString *)getNetworkFailureMsg
{
    return [self.error.userInfo objectForKey:@"NSLocalizedDescription"];
}

@end
