#import <Foundation/Foundation.h>

extern const int kASCIISymbolsCount;

@interface AsciiCounter : NSURLComponents

- (char)mostFrequentCharacterInSequence:(char*)str ofSize:(int)size;

@end
