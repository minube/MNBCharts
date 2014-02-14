//
//  MNBViewController.m
//  MNBCharts
//
//  Created by Ruben on 14/02/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "MNBViewController.h"
#import "MNBRoundedChart.h"

@interface MNBViewController ()
@property (strong, nonatomic) IBOutlet MNBRoundedChart *roundedChart;
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
    self.roundedChart.filledColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation:(id)sender
{
    [self.roundedChart startPresentingCircleWithColor:[UIColor blueColor] endValue:0.8 animationWithDuration:2.0 completion:^(BOOL finished) {
        NSLog(@"Animation did end");
    }];
}
@end
