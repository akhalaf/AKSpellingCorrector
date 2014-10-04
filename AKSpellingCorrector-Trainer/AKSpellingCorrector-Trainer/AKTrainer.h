//
//  AKTrainer.h
//  AKSpellingCorrector-Trainer
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKTrainer : NSObject

-(id)initWithFileName:(NSString *)fileName;
-(void)train;

@end
