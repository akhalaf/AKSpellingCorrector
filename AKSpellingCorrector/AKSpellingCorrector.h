//
//  AKSpellingCorrector.h
//  AKSpellingCorrector
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  `AKSpellingCorrector` is a simple spelling checker, takes a word with max 10 letters length, and returns the most popular correct word of this wrong one.
 
    This is an 'Objective C' spelling corrector based on Peter Norvig's article, and you can find it on this URL:
    http://norvig.com/spell-correct.html
 
    @note Please feel free to browse the code, and add your custom changes as you wish.
 */
@interface AKSpellingCorrector : NSObject

/**
 *  This method corrects any single word.
 *
 *  @param word NSString of the word you want to correct it.
 *
 *  @return NSString of the corrected word.
 */
- (NSString*)correctWord:(NSString*)word;

/**
 *  This method checks if the input word exist in the words dictionary.
 *
 *  @param word NSString of the word you want to check it.
 *
 *  @return A BOOL with YES in case of the word exists in the dictionary, and NO otherwise.
 */
- (BOOL)checkWord:(NSString*)word;

/**
 *  A singleton method return a shared object of `AKSpellingCorrector`.
 *
 *  @return shared object of `AKSpellingCorrector`.
 */
+ (instancetype)sharedInstance;

@end
