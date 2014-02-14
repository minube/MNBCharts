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
@property (nonatomic, assign) CAShapeLayer *circle;
@property (nonatomic, copy) MNBRoundedChartCompletionCallback completion;
@end

@implementation MNBRoundedChart

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
    // Set up the shape of the circle
    CGFloat rectWidth = CGRectGetWidth(rect);
    CGFloat rectHeight = CGRectGetHeight(rect);
    
    CGFloat smallestSide = rectWidth < rectHeight ? rectWidth : rectHeight;
    
    CGFloat radius = floorf(smallestSide / 2.0);
    CGPoint center = CGPointMake(rectWidth / 4.0,
                                 rectHeight / 4.0);
    CGFloat lineWidth = 40;
    CGFloat circleRadius = radius - floorf(lineWidth / 2.0);
    CGFloat filledCircleRadius = circleRadius - floorf(lineWidth / 2.0);
    
    // Filled Circle
    CAShapeLayer *filledCircle = [CAShapeLayer layer];
    filledCircle.path = [UIBezierPath bezierPathWithArcCenter:center radius:filledCircleRadius startAngle:0 endAngle:2 * M_PI clockwise:YES].CGPath;
    filledCircle.position = center;
    filledCircle.fillColor = [UIColor whiteColor].CGColor;
    filledCircle.strokeColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:filledCircle];
    
    // Circle
    self.circle = [CAShapeLayer layer];
    self.circle.path = [UIBezierPath bezierPathWithArcCenter:center radius:circleRadius startAngle:3 * M_PI_2 endAngle:M_PI clockwise:YES].CGPath;
    self.circle.position = center;
    self.circle.fillColor = [UIColor clearColor].CGColor;
    self.circle.strokeColor = [UIColor clearColor].CGColor;
    self.circle.lineWidth = lineWidth;
    [self.layer addSublayer:self.circle];
}


- (void)startPresentingCircleWithColor:(UIColor *)color animationWithDuration:(CGFloat)duration
{
    [self startPresentingCircleWithColor:color animationWithDuration:duration completion:nil];
}

- (void)startPresentingCircleWithColor:(UIColor *)color animationWithDuration:(CGFloat)duration completion:(MNBRoundedChartCompletionCallback)completion
{
    UIColor *circleColor = [UIColor whiteColor];
    if (color) {
        circleColor = color;
    }
    self.completion = completion;
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

@end
