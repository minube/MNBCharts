//
//  MNBRoundedChart.m
//  MNBCharts
//
//  Created by Ruben on 14/02/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "MNBRoundedChart.h"

static NSString * const MNBRoundedChartAnimationKey = @"drawCircleAnimation";

@interface MNBRoundedChart ()
@property (nonatomic, assign) CGPoint circlesCenter;
@property (nonatomic, strong) CAShapeLayer *circle;
@property (nonatomic, strong) CAShapeLayer *filledCircle;
@property (nonatomic, assign) CGFloat circleRadius;
@property (nonatomic, copy) MNBRoundedChartCompletionCallback completion;
@property (nonatomic, assign) CGFloat lineWidth;
@end

@implementation MNBRoundedChart

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame lineWidth:[MNBRoundedChart defaultLineWidthForFrame:frame]];
}

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.lineWidth = [MNBRoundedChart defaultLineWidthForFrame:self.frame];
}

- (void)drawRect:(CGRect)rect
{
    // Set up the shape of the circle
    CGFloat rectWidth = CGRectGetWidth(rect);
    CGFloat rectHeight = CGRectGetHeight(rect);
    
    CGFloat smallestSide = rectWidth < rectHeight ? rectWidth : rectHeight;
    
    CGFloat radius = floorf(smallestSide / 2.0);
    self.circlesCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    self.circleRadius = radius - floorf(self.lineWidth / 2.0);
    CGFloat filledCircleRadius = self.circleRadius - floorf(self.lineWidth / 2.0);
    
    // Filled Circle
    self.filledCircle = [CAShapeLayer layer];
    self.filledCircle.path = [UIBezierPath bezierPathWithArcCenter:self.circlesCenter radius:filledCircleRadius startAngle:0 endAngle:2 * M_PI clockwise:YES].CGPath;
    self.filledCircle.fillColor = self.filledColor.CGColor;
    self.filledCircle.strokeColor = self.filledColor.CGColor;
    [self.layer addSublayer:self.filledCircle];
}


- (void)startPresentingCircleWithColor:(UIColor *)color endValue:(CGFloat)endValue animationWithDuration:(CGFloat)duration
{
    [self startPresentingCircleWithColor:color endValue:endValue animationWithDuration:duration completion:nil];
}

- (void)startPresentingCircleWithColor:(UIColor *)color endValue:(CGFloat)endValue animationWithDuration:(CGFloat)duration completion:(MNBRoundedChartCompletionCallback)completion
{
    NSAssert1(endValue >= 0 && endValue <= 1, @"End Value must be between 0 and 1. You set endValue = %f", endValue);
    self.completion = completion;
    
    if (self.circle) {
        [self.circle removeFromSuperlayer];
    }
    
    // Circle
    self.circle = [CAShapeLayer layer];
    self.circle.path = [UIBezierPath bezierPathWithArcCenter:self.circlesCenter radius:self.circleRadius startAngle:3 * M_PI_2 endAngle:endValue * 4 * M_PI clockwise:YES].CGPath;
    self.circle.fillColor = [UIColor clearColor].CGColor;
    self.circle.strokeColor = [UIColor clearColor].CGColor;
    self.circle.lineWidth = self.lineWidth;
    [self.layer addSublayer:self.circle];
    
    UIColor *circleColor = [UIColor whiteColor];
    if (color) {
        circleColor = color;
    }
    
    self.circle.strokeColor = circleColor.CGColor;

    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = duration;
    drawAnimation.repeatCount         = 1.0;
    
    drawAnimation.fromValue = [NSNumber numberWithFloat:0];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    drawAnimation.delegate = self;
    drawAnimation.removedOnCompletion = NO;
    [self.circle addAnimation:drawAnimation forKey:MNBRoundedChartAnimationKey];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    if (animation == [self.circle animationForKey:MNBRoundedChartAnimationKey]) {
        [self.circle removeAllAnimations];
        if (self.completion) {
            self.completion(flag);
            self.completion = nil;
        }
    }
}

#pragma mark - Default
+ (CGFloat)defaultLineWidthForFrame:(CGRect)rect
{
    CGFloat rectWidth = CGRectGetWidth(rect);
    CGFloat rectHeight = CGRectGetHeight(rect);
    
    CGFloat smallestSide = rectWidth < rectHeight ? rectWidth : rectHeight;
    return smallestSide * 0.1;
}

#pragma mark - Setters
- (void)setFilledColor:(UIColor *)filledColor
{
    if (_filledColor != filledColor) {
        _filledColor = filledColor;
        if (self.filledCircle) {
            self.filledCircle.fillColor = _filledColor.CGColor;
        }
    }
}

@end
