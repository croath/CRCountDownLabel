//
//  ViewController.m
//  CountDownView
//
//  Created by croath on 1/6/15.
//  Copyright (c) 2015 Croath. All rights reserved.
//

#import "ViewController.h"
#import "CRCountDownLabel.h"

@interface ViewController (){
    CRCountDownLabel *_label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _label = [[CRCountDownLabel alloc] initWithFrame:CGRectMake(50.0, 100.0, 200.0, 50.0)];
    [_label setFont:[UIFont systemFontOfSize:30.0]];
    [_label setEndingDate:[[NSDate date] dateByAddingTimeInterval:10000.0]];
    [self.view addSubview:_label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
