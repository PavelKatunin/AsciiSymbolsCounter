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
    XCTAssertEqual('c', [counter mostFrequentCharacterInSequence:"ababaccccc" ofSize:10]);
}

- (void) testDiversity
{
  AsciiCounter *counter = [[AsciiCounter alloc] init];
  unsigned int maxPossibleLength = -1;    //здесь будет максимальный unsigned int
  //если мы его поделим пополам, у нас получится как раз максимальный int
  maxPossibleLength = maxPossibleLength/2;
  
  const size_t length = (size_t)maxPossibleLength;
  char *array = malloc(length * sizeof(char));
  char mostFrequentChar;
  //делаю равномерное распределение символов по массиву (если забью нулями - ноль будет преобладать)
  for (size_t i = 0; i < length; ++i) {
    array[i] = (char)(i % kASCIISymbolsCount);
  }
  //в начало вписываю символы 'a', 'a' и 'b' - теперь они будут преобладать
  for (size_t i = 0; i < 3; ++i) {
    if (!i || (i==1)) {
      array[i] = 'a';
    } else {
      array[i] = 'b';
    }
  }
  mostFrequentChar = [counter mostFrequentCharacterInSequence: array
                                                       ofSize: (int)length];
  XCTAssertEqual(mostFrequentChar, 'a');
  //проверяю массив без 1 символа - тоже должна преобладать 'a'
  mostFrequentChar = [counter mostFrequentCharacterInSequence: (array + sizeof(char) * 1)
                                                       ofSize: (int)length - 1];
  XCTAssertEqual(mostFrequentChar, 'a');
  //без двух символов - уже должна преобладать 'b'
  mostFrequentChar = [counter mostFrequentCharacterInSequence: (array + sizeof(char) * 2)
                                                       ofSize: (int)length - 2];
  XCTAssertEqual(mostFrequentChar, 'b');
  free(array);
}

- (void) testMajority
{
  AsciiCounter *counter = [[AsciiCounter alloc] init];
  unsigned int maxPossibleLength = -1;    //здесь будет максимальный unsigned int
  //если мы его поделим пополам, у нас получится как раз максимальный int
  maxPossibleLength = maxPossibleLength/2;
  
  const size_t length = (size_t)maxPossibleLength;
  char *array = malloc(length * sizeof(char));
  char mostFrequentChar;
  for (size_t i = 0; i < length; ++i) {
    //если size_t совпадет по размеру с int, беды не будет (так как length половина от беззнакового)
    if (!(i%2)) {
      array[i] = 't';
    }
  }
  mostFrequentChar = [counter mostFrequentCharacterInSequence: array
                                                       ofSize: (int)length];
  //mostFrequentCharacter (array, (int)length);
  XCTAssertEqual(mostFrequentChar, 't');
  free(array);
}

@end
