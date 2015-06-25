//
//  RedmartNewProductsTests.m
//  RedmartNewProductsTests
//
//  Created by Shekhar  on 24/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Helper.h"
#import "WebServiceManager.h"
#import "Constants.h"
#import "OCMockObject.h"
#import "WebServiceManager.h"
#import "ProductsCatalogueVC.h"
#import "OCMArg.h"
#import "ImageViewer.h"

@interface RedmartNewProductsTests : XCTestCase<WebServiceManagerDelegate>

@property (nonatomic,strong) WebServiceManager *webServiceManager;
@end

@implementation RedmartNewProductsTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 Test Case
 */
- (void)testSavedProducts {
    NSArray *products = [mDataManager loadFirstPageofProducts];
    XCTAssertNotNil(products, @"Failed to get Saved products or the data is not cached yet");
}

@end
