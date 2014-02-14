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
- (void)startPresentingCircleWithColor:(UIColor *)color animationWithDuration:(CGFloat)duration;
- (void)startPresentingCircleWithColor:(UIColor *)color animationWithDuration:(CGFloat)duration completion:(MNBRoundedChartCompletionCallback)completion;
@end
