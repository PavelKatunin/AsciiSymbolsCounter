#import "AsciiCounter.h"

const int kASCIISymbolsCount = 256;

int* fillMappingArrayInSequence(char* str, int size, int* asciiMappingArray) {
    
    for (int currentSymbolPosition = 0; currentSymbolPosition < size; currentSymbolPosition++) {
        asciiMappingArray[str[currentSymbolPosition]]++;
    }
    return asciiMappingArray;
}

int* mergeMappingArraysToFirst(int* array1, int* array2) {
    for (int currentAsciiSymbol = 0; currentAsciiSymbol < kASCIISymbolsCount; currentAsciiSymbol++) {
        array1[currentAsciiSymbol] = array1[currentAsciiSymbol] + array2[currentAsciiSymbol];
    }
    return array1;
}

char mostFrequentCharacterFromMappingArray(int *array) {
    int maxCount = 0;
    char maxCountPosition = 0;
    for (char currentAsciiSymbol = 0; currentAsciiSymbol < kASCIISymbolsCount; currentAsciiSymbol++) {
        if (array[currentAsciiSymbol] > maxCount) {
            maxCount = array[currentAsciiSymbol];
            maxCountPosition = currentAsciiSymbol;
        }
    }
    return maxCountPosition;
}

char mostFrequentCharacterInSequence(char* str, int size) {
    int size1 = size / 2;
    int size2 = size - size1;
    
    __block int * asciiMappingArray1 = (int *)calloc(kASCIISymbolsCount, sizeof(int));
    __block int * asciiMappingArray2 = (int *)calloc(kASCIISymbolsCount, sizeof(int));
    
    dispatch_queue_t queue = dispatch_queue_create("concurent.char", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        fillMappingArrayInSequence(str, size1, asciiMappingArray1);
    });
    
    dispatch_async(queue, ^{
        fillMappingArrayInSequence(str + size1, size2, asciiMappingArray2);
    });

    dispatch_barrier_sync(queue, ^{
      mergeMappingArraysToFirst(asciiMappingArray1, asciiMappingArray2);
    });
    
    char resultChar = mostFrequentCharacterFromMappingArray(asciiMappingArray1);
    
    free(asciiMappingArray1);
    free(asciiMappingArray2);
    
    return resultChar;
}

@implementation AsciiCounter

- (char)mostFrequentCharacterInSequence:(char*) str ofSize:(int)size {
    return mostFrequentCharacterInSequence(str, size);
}

@end
