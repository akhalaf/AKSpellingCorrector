//
//  AKTrainer.m
//  AKSpellingCorrector-Trainer
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import "AKTrainer.h"
#import "AKWord.h"
#import "AKCoreDataObjects.h"

#define alphabet "abcdefghijklmnopqrstuvwxyz"

@implementation AKTrainer
{
    NSString* filePath;
    NSMutableDictionary* dictionary;
    NSArray* wordsArray;
}


-(id)initWithFileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        filePath = [[NSBundle mainBundle] pathForResource:fileName
                                                   ofType:@"txt"];
        dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)train
{
    NSString* content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    content = [content lowercaseString];
    
    NSCharacterSet *charactersToRemove = [[NSCharacterSet characterSetWithCharactersInString:@alphabet] invertedSet];

    wordsArray = [content componentsSeparatedByCharactersInSet:charactersToRemove];
    
    for (NSString* word in wordsArray) {
        if (word.length > 0) {
            [self addWord:word];
        }
    }
    
    for (AKWord* word in dictionary.objectEnumerator) {
        [word save];
    }
    
    [[AKCoreDataObjects sharedInstance]save];
}

-(void)addWord:(NSString*)string
{
    AKWord* word = [dictionary objectForKey:string];
    if (!word) {
        word = [[AKWord alloc]initWithWord:string
                               frequency:0];
        [dictionary setObject:word
                       forKey:string];
    }
    word.frequency++;
}

@end
