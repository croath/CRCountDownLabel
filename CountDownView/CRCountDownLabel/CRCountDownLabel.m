//
//  CRCountDownLabel.m
//  CountDownView
//
//  Created by croath on 1/6/15.
//  Copyright (c) 2015 Croath. All rights reserved.
//

#import "CRCountDownLabel.h"

@interface CRCountDownLabel()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger remainingTime;
@property (nonatomic, strong) UIFont *letterFont;

@end

@implementation CRCountDownLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.innerSpaceRatio = 0.5;
    self.spaceRatio = 0.3;
    self.letterColor = [UIColor whiteColor];
    self.letterbackColor = [UIColor darkGrayColor];
    self.colonColor = [UIColor darkGrayColor];
    self.font = [UIFont systemFontOfSize:14.0];
}

- (void)setEndingDate:(NSDate *)endingDate{
    _endingDate = endingDate;
    [self createTimer];
}

- (void)setFont:(UIFont *)font{
    self.letterFont = font;
}

- (void)createTimer{
    self.timer = [[NSTimer alloc] initWithFireDate:[NSDate date]
                                          interval:1.0
                                            target:self
                                          selector:@selector(updateLabel)
                                          userInfo:nil
                                           repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    _remainingTime = (NSInteger)[self.endingDate timeIntervalSinceDate:[NSDate date]];
}

- (void)updateLabel{
    _remainingTime -= 1;
    int hour = (int)_remainingTime / (60*60);
    int minute = ((int)_remainingTime / 60) % 60;
    int second = (int)_remainingTime % 60;
    
    if (hour >= 99) {
        hour = 99;
    }
    
    [self setAttributedText:[self generateAttrStringWithHour:hour minute:minute second:second]];
    
    if (hour + minute + second <= 0) {
        [self.timer invalidate];
    }
}

- (NSAttributedString*)generateAttrStringWithHour:(int)hour
                                           minute:(int)minute
                                           second:(int)second{
    NSString *hourStr = [NSString stringWithFormat:@"%02d", hour];
    NSString *minuteStr = [NSString stringWithFormat:@"%02d", minute];
    NSString *secondStr = [NSString stringWithFormat:@"%02d", second];
    
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle * numberStyle = [[NSMutableParagraphStyle alloc] init];
    numberStyle.lineBreakMode = self.lineBreakMode;
    numberStyle.alignment = self.textAlignment;
    
    NSAttributedString *hourAttrStr = [[NSAttributedString alloc] initWithString:hourStr attributes:
                                       @{NSFontAttributeName:self.letterFont,
                                         NSBackgroundColorAttributeName:[UIColor darkGrayColor],
                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                         NSParagraphStyleAttributeName:numberStyle}];
    
    NSAttributedString *minuteAttrStr = [[NSAttributedString alloc] initWithString:minuteStr attributes:
                                       @{NSFontAttributeName:self.letterFont,
                                         NSBackgroundColorAttributeName:[UIColor darkGrayColor],
                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                         NSParagraphStyleAttributeName:numberStyle}];
    
    NSAttributedString *secondAttrStr = [[NSAttributedString alloc] initWithString:secondStr attributes:
                                       @{NSFontAttributeName:self.letterFont,
                                         NSBackgroundColorAttributeName:[UIColor darkGrayColor],
                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                         NSParagraphStyleAttributeName:numberStyle}];
    
    NSAttributedString *colonAttrStr = [[NSAttributedString alloc] initWithString:@":" attributes:
                                        @{NSFontAttributeName:self.letterFont,
                                          NSBackgroundColorAttributeName:[UIColor clearColor],
                                          NSForegroundColorAttributeName:[UIColor blackColor],
                                          NSParagraphStyleAttributeName:numberStyle}];
    
    NSAttributedString *innerSpaceAttrStr = [[NSAttributedString alloc] initWithString:@" " attributes:
                                             @{NSFontAttributeName:[UIFont systemFontOfSize:self.letterFont.pointSize*self.innerSpaceRatio],
                                               NSBackgroundColorAttributeName:[UIColor darkGrayColor],
                                               NSForegroundColorAttributeName:[UIColor whiteColor],
                                               NSParagraphStyleAttributeName:numberStyle}];
    
    NSAttributedString *spaceAttrStr = [[NSAttributedString alloc] initWithString:@" " attributes:
                                        @{NSFontAttributeName:[UIFont systemFontOfSize:self.letterFont.pointSize*self.spaceRatio],
                                          NSBackgroundColorAttributeName:[UIColor clearColor],
                                          NSForegroundColorAttributeName:[UIColor blackColor],
                                          NSParagraphStyleAttributeName:numberStyle}];
    
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:[hourAttrStr attributedSubstringFromRange:NSMakeRange(0, 1)]];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:spaceAttrStr];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:[hourAttrStr attributedSubstringFromRange:NSMakeRange(1, 1)]];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    
    [attrStr appendAttributedString:spaceAttrStr];
    [attrStr appendAttributedString:colonAttrStr];
    [attrStr appendAttributedString:spaceAttrStr];
    
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:[minuteAttrStr attributedSubstringFromRange:NSMakeRange(0, 1)]];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:spaceAttrStr];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:[minuteAttrStr attributedSubstringFromRange:NSMakeRange(1, 1)]];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    
    [attrStr appendAttributedString:spaceAttrStr];
    [attrStr appendAttributedString:colonAttrStr];
    [attrStr appendAttributedString:spaceAttrStr];
    
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:[secondAttrStr attributedSubstringFromRange:NSMakeRange(0, 1)]];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:spaceAttrStr];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    [attrStr appendAttributedString:[secondAttrStr attributedSubstringFromRange:NSMakeRange(1, 1)]];
    [attrStr appendAttributedString:innerSpaceAttrStr];
    
    return attrStr;
}

@end
