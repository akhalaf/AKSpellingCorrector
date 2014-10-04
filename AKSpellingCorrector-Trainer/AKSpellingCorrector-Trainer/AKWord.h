//
//  AKWord.h
//  AKSpellingCorrector-Trainer
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKWord : NSObject

@property (nonatomic, retain) NSString* word;
@property (nonatomic) int frequency;

-(id)initWithWord:(NSString*)_word
          frequency:(int)_frequency;
-(void)save;

@end
