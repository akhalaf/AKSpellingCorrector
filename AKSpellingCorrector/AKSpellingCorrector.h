//
//  AKSpellingCorrector.h
//  AKSpellingCorrector
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKSpellingCorrector : NSObject

- (NSString*)correctWord:(NSString*)word;

+ (AKSpellingCorrector*)sharedInstance;

@end
