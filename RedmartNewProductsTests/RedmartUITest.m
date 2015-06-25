//
//  RedmartUITest.m
//  RedmartNewProducts
//
//  Created by Shekhar  on 25/6/15.
//  Copyright (c) 2015 Redmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ImageViewer.h"
#import "OCMockObject.h"
#import "OCMArg.h"
#import "DoActionSheet.h"

@interface RedmartUITest : XCTestCase
{
    ImageViewer *imageViewer;
}

@end

@implementation RedmartUITest

- (void)setUp {
    [super setUp];
    imageViewer = [[ImageViewer alloc]init];
    [imageViewer view];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testImageViewerButton{

    [imageViewer.btnSave sendActionsForControlEvents: UIControlEventTouchUpInside];
    XCTAssertNotNil([imageViewer actionSheet], @"ViewController should contain an action sheet");
}

- (void)testImageViewerView {
    XCTAssertNotNil([imageViewer view], @"ViewController should contain a view");
}




@end
