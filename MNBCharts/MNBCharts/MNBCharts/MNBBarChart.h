//
//  MNBBarChart.h
//  MNBCharts
//
//  Created by Ruben on 14/02/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MNBBarChartCompletionCallback)(BOOL finished);

@interface MNBBarChart : UIView
@property (nonatomic, strong) UIColor *backgroundColor;

- (void)startPresentingWithColor:(UIColor *)color endValue:(CGFloat)endValue animationWithDuration:(CGFloat)duration;
- (void)startPresentingWithColor:(UIColor *)color endValue:(CGFloat)endValue animationWithDuration:(CGFloat)duration completion:(MNBBarChartCompletionCallback)completion;
@end
