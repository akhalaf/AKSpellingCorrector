//
//  AKWord.m
//  AKSpellingCorrector-Trainer
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import "AKWord.h"
#import "AKCoreDataObjects.h"
#import "AKDictionary.h"

@implementation AKWord
{
    AKDictionary* dictionaryModal;
}

@synthesize frequency;
@synthesize word;

-(id)initWithWord:(NSString *)_word
          frequency:(int)_frequency
{
    self = [super init];
    if (self) {
        word = _word;
        frequency = _frequency;
    }
    return self;
}

-(void)save
{
    NSManagedObjectContext* context = [[AKCoreDataObjects sharedInstance] managedObjectContext];
    dictionaryModal = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Dictionary"
                       inManagedObjectContext:context];
    dictionaryModal.word = word;
    dictionaryModal.frequency = [NSNumber numberWithInt:frequency];

    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end
