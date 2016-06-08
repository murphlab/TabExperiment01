//
//  FeaturedViewController.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "FeaturedViewController.h"
#import "DashboardTabViewController.h"

@interface FeaturedViewController ()

@end

@implementation FeaturedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"FeaturedViewController: viewDidLoad");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"FeaturedViewController: viewDidAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)collapseTapped:(id)sender {
    if ([self.parentViewController isKindOfClass:[DashboardTabViewController class]]) {
        DashboardTabViewController *dtvc = (DashboardTabViewController *)self.parentViewController;
        [dtvc setBarCollapsed:!dtvc.barCollapsed animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
