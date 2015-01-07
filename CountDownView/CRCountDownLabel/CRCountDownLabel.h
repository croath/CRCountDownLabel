//
//  CRCountDownLabel.h
//  CountDownView
//
//  Created by croath on 1/6/15.
//  Copyright (c) 2015 Croath. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface CRCountDownLabel : UILabel

@property (nonatomic, strong) NSDate *endingDate;
@property (nonatomic, assign) CGFloat innerSpaceRatio;
@property (nonatomic, assign) CGFloat spaceRatio;
@property (nonatomic, strong) UIColor *letterbackColor;
@property (nonatomic, strong) UIColor *letterColor;
@property (nonatomic, strong) UIColor *colonColor;

@end
