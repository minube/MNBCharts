//
//  MNBRoundedChart.h
//  MNBCharts
//
//  Created by Ruben on 14/02/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MNBRoundedChartCompletionCallback)(BOOL finished);

@interface MNBRoundedChart : UIView
@property (nonatomic, strong) UIColor *filledColor;

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth;
- (void)startPresentingCircleWithColor:(UIColor *)color endValue:(CGFloat)endValue animationWithDuration:(CGFloat)duration;
- (void)startPresentingCircleWithColor:(UIColor *)color endValue:(CGFloat)endValue animationWithDuration:(CGFloat)duration completion:(MNBRoundedChartCompletionCallback)completion;
@end
