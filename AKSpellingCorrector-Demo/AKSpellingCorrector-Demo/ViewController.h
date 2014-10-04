//
//  ViewController.h
//  AKSpellingCorrector-Demo
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UILabel *correctedText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (IBAction)correctAction:(id)sender;
@end

