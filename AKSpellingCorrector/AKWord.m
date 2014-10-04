//
//  AKWord.m
//  AKSpellingCorrector
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import "AKWord.h"
#import "AKCoreDataObjects.h"
#import "AKDictionary.h"

@implementation AKWord

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

-(id)initWithModelObject:(AKDictionary*)model
{
    self = [super init];
    if (self) {
        word = model.word;
        frequency = [model.frequency intValue];
    }
    return self;
}

+(AKWord *)getWordWithExactString:(NSString *)string
{
    NSManagedObjectContext* context = [[AKCoreDataObjects sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dictionary"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"word == %@", string];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (AKDictionary *wordObject in fetchedObjects) {
        return [[AKWord alloc] initWithModelObject:wordObject];
    }
    return nil;
}

+(NSArray *)getWordWithStartingString:(NSString *)string
{
    NSManagedObjectContext* context = [[AKCoreDataObjects sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dictionary"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"word BEGINSWITH[c] %@", string];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray* result = [NSMutableArray array];
    for (AKDictionary *wordObject in fetchedObjects) {
        [result addObject:[[AKWord alloc] initWithModelObject:wordObject]];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"frequency"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [result sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

+(NSDictionary*)getAllWords
{
    NSManagedObjectContext* context = [[AKCoreDataObjects sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dictionary"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    for (AKDictionary *wordObject in fetchedObjects) {
        [result setObject:[[AKWord alloc] initWithModelObject:wordObject]
                   forKey:wordObject.word];
    }
    return result;
}

@end
