//
//  MNBBarChart.m
//  MNBCharts
//
//  Created by Ruben on 14/02/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "MNBBarChart.h"

static NSString * const MNBBarChartAnimationKey = @"moveBarAnimation";

@interface MNBBarChart ()<CAAnimationDelegate>
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *barChartLayer;
@property (nonatomic, copy) MNBBarChartCompletionCallback completion;
@end

@implementation MNBBarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.backgroundLayer = [CAShapeLayer layer];
    CGPathRef pathBarChart = CGPathCreateWithRect(rect, NULL);
    self.backgroundLayer.path = pathBarChart;
    self.backgroundLayer.fillColor = self.backgroundColor.CGColor;
    self.backgroundLayer.frame = rect;
    [self.layer addSublayer:self.backgroundLayer];
    
    self.layer.cornerRadius = CGRectGetHeight(rect) / 2.0;
    self.layer.masksToBounds = YES;
}

- (void)startPresentingWithColor:(UIColor *)color endValue:(CGFloat)endValue animationWithDuration:(CGFloat)duration
{
    [self startPresentingWithColor:color endValue:endValue animationWithDuration:duration completion:nil];
}

- (void)startPresentingWithColor:(UIColor *)color endValue:(CGFloat)endValue animationWithDuration:(CGFloat)duration completion:(MNBBarChartCompletionCallback)completion
{
    NSAssert1(endValue >= 0 && endValue <= 1, @"End Value must be between 0 and 1. You set endValue = %f", endValue);
    self.completion = completion;
    
    if (self.barChartLayer) {
        [self.barChartLayer removeFromSuperlayer];
    }
    
    UIColor *barColor = [UIColor whiteColor];
    if (color) {
        barColor = color;
    }
    
    // Background
    self.barChartLayer = [CAShapeLayer layer];
    CGRect barCharLayerFrame = self.backgroundLayer.frame;
    barCharLayerFrame.size.width = endValue * barCharLayerFrame.size.width;
    
    self.barChartLayer.path = CGPathCreateWithRect(barCharLayerFrame, NULL);
    self.barChartLayer.frame = barCharLayerFrame;
    self.barChartLayer.fillColor = barColor.CGColor;
    [self.backgroundLayer addSublayer:self.barChartLayer];
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    drawAnimation.duration            = duration;
    drawAnimation.repeatCount         = 1.0;
    CGRect initialBounds = self.barChartLayer.bounds;
    initialBounds.origin.x = initialBounds.size.width;
    drawAnimation.fromValue = [NSValue valueWithCGRect:initialBounds];
    drawAnimation.toValue   = [NSValue valueWithCGRect:self.barChartLayer.bounds];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    drawAnimation.delegate = self;
    drawAnimation.removedOnCompletion = NO;
    [self.barChartLayer addAnimation:drawAnimation forKey:MNBBarChartAnimationKey];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    if (animation == [self.barChartLayer animationForKey:MNBBarChartAnimationKey]) {
        [self.barChartLayer removeAllAnimations];
        if (self.completion) {
            self.completion(flag);
            self.completion = nil;
        }
    }
}

#pragma mark - Setters
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (_backgroundColor != backgroundColor) {
        _backgroundColor = backgroundColor;
        if (self.backgroundLayer) {
            self.backgroundLayer.fillColor = _backgroundColor.CGColor;
        }
    }
}

@end
