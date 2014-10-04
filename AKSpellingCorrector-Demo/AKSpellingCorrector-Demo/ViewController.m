//
//  ViewController.m
//  AKSpellingCorrector-Demo
//
//  Created by Ahmed Khalaf on 10/4/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import "ViewController.h"
#import "AKSpellingCorrector.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // this line will load all words into memory
    [AKSpellingCorrector sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)correctAction:(id)sender {
    NSDate* beforeCorrection = [NSDate date];
    
    self.correctedText.text = [[AKSpellingCorrector sharedInstance]correctWord:self.inputText.text];
    
    NSTimeInterval correctionTime = [[NSDate date]timeIntervalSinceDate:beforeCorrection];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%f sec", correctionTime];
}
@end
