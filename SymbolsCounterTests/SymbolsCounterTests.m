//
//  SymbolsCounterTests.m
//  SymbolsCounterTests
//
//  Created by Pavel on 06/04/15.
//  Copyright (c) 2015 Katunin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AsciiCounter.h"

@interface SymbolsCounterTests : XCTestCase

@end

@implementation SymbolsCounterTests

- (void)testAsciiCounter {
    AsciiCounter *counter = [[AsciiCounter alloc] init];
    XCTAssertEqual('e', [counter mostFrequentCharacterInSequence:"ehejenekek" ofSize:10]);
    XCTAssertEqual('k', [counter mostFrequentCharacterInSequence:"kkkjenekek" ofSize:10]);
}

@end
