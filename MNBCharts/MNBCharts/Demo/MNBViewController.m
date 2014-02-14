//
//  MNBViewController.m
//  MNBCharts
//
//  Created by Ruben on 14/02/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "MNBViewController.h"
#import "MNBRoundedChart.h"
#import "MNBBarChart.h"

@interface MNBViewController ()
@property (strong, nonatomic) IBOutlet MNBRoundedChart *roundedChart;
@property (strong, nonatomic) IBOutlet MNBBarChart *barChart;
@property (strong, nonatomic) IBOutlet MNBBarChart *barChart2;
@property (strong, nonatomic) IBOutlet MNBBarChart *barChart3;
- (IBAction)startAnimation:(id)sender;
@end

@implementation MNBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.roundedChart.filledColor = [UIColor colorWithRed:24.0/255.0 green:30.0/255.0 blue:38.0/255.0 alpha:1.0];
    self.barChart.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:57.0/255.0 blue:70.0/255.0 alpha:1.0];
    self.barChart2.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:57.0/255.0 blue:70.0/255.0 alpha:1.0];
    self.barChart3.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:57.0/255.0 blue:70.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation:(id)sender
{
    [self.roundedChart startPresentingCircleWithColor:[UIColor colorWithRed:49.0/255.0 green:57.0/255.0 blue:70.0/255.0 alpha:1.0] endValue:0.8 animationWithDuration:1.0 completion:^(BOOL finished) {
        NSLog(@"Animation did end");
    }];
    
    [self.barChart startPresentingWithColor:[UIColor colorWithRed:244.0/255.0 green:129.0/255.0 blue:0.0 alpha:1.0] endValue:0.8 animationWithDuration:1.0 completion:^(BOOL finished) {
        NSLog(@"Animation did end");
    }];
    
    [self.barChart2 startPresentingWithColor:[UIColor colorWithRed:244.0/255.0 green:129.0/255.0 blue:0.0 alpha:1.0] endValue:0.4 animationWithDuration:1.0 completion:^(BOOL finished) {
        NSLog(@"Animation did end");
    }];
    
    [self.barChart3 startPresentingWithColor:[UIColor colorWithRed:244.0/255.0 green:129.0/255.0 blue:0.0 alpha:1.0] endValue:0.9 animationWithDuration:1.0 completion:^(BOOL finished) {
        NSLog(@"Animation did end");
    }];
}
@end
