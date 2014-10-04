//
//  AKSpellingCorrector.m
//  AKSpellingCorrector
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import "AKSpellingCorrector.h"
#import "AKWord.h"

#define alphabet @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"]

@implementation AKSpellingCorrector
{
    NSDictionary* dictionary;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        dictionary = [AKWord getAllWords];
    }
    return self;
}

-(NSString *)correctWord:(NSString*)string {
    if (string.length > 10) {
        return string;
    }
    
    string = [string lowercaseString];
    
    NSArray* knownStrings = [self known:[NSArray arrayWithObject:string]];
    if (knownStrings) {
        return string;
    }
    
    knownStrings = [self known:[self edits1:string]];
    if (knownStrings) {
        return [self wordWithMaxFrequencyFromWords:knownStrings];
    }
    
    knownStrings = [self known:[self edits2:string]];
    if (knownStrings) {
        return [self wordWithMaxFrequencyFromWords:knownStrings];
    }
    
    return string;
}

-(NSArray*)known:(NSArray*)strings {
    NSMutableArray* knownWords = [NSMutableArray array];
    for (NSString* string in strings) {
        AKWord* word = [dictionary objectForKey:string];
        if (word) {
            [knownWords addObject:word];
        }
    }
    if (knownWords.count == 0) {
        return nil;
    }
    return knownWords;
}

-(NSArray*)edits1:(NSString*)string {
    NSMutableArray* results = [NSMutableArray array];
    
    for (int i = 0; i <= string.length; i++) {
        NSString* a = [string substringToIndex:i];
        NSString* b = [string substringFromIndex:i];
        
        // deletes
        if (b.length > 0) {
            [results addObject:[a stringByAppendingString:[b substringFromIndex:1]]];
        }
        
        // transposes
        if (b.length > 1) {
            [results addObject:[NSString stringWithFormat:@"%@%C%C%@", a, [b characterAtIndex:1], [b characterAtIndex:0], [b substringFromIndex:2]]];
        }
        
        // replaces
        if (b.length > 0) {
            for (NSString* letter in alphabet) {
                [results addObject:[a stringByAppendingString:[letter stringByAppendingString:[b substringFromIndex:1]]]];
            }
        }
        
        // inserts
        for (NSString* letter in alphabet) {
            [results addObject:[a stringByAppendingString:[letter stringByAppendingString:b]]];
        }
    }
    return results;
}

-(NSArray*)edits2:(NSString*)string {
    NSMutableArray* results = [NSMutableArray array];
    NSArray* edits1 = [self edits1:string];
    
    for (NSString* editedString in edits1) {
        [results addObjectsFromArray:[self edits1:editedString]];
    }
    return results;
}

-(NSString*)wordWithMaxFrequencyFromWords:(NSArray*)words {
    int maxFrequency = 0;
    NSString* word;
    for (AKWord* wordObject in words) {
        if (wordObject.frequency > maxFrequency) {
            maxFrequency = wordObject.frequency;
            word = wordObject.word;
        }
    }
    return word;
}

+ (AKSpellingCorrector*)sharedInstance {
    static AKSpellingCorrector *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[AKSpellingCorrector alloc] init];
    });
    return _sharedInstance;
}

@end
