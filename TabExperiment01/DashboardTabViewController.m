//
//  DashboardTabViewController.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "DashboardTabViewController.h"

@interface DashboardTabViewController ()
@property (weak, nonatomic) IBOutlet UIButton *favoritesButton;
@property (weak, nonatomic) IBOutlet UIButton *featuredButton;
@end

@implementation DashboardTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *favoritesVC = [sb instantiateViewControllerWithIdentifier:@"Favorites"];
    UIViewController *featuredVC = [sb instantiateViewControllerWithIdentifier:@"Featured"];
    self.viewControllers = @[ favoritesVC, featuredVC ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favoritesButtonTapped:(id)sender {
}

- (IBAction)featuredButtonTapped:(id)sender {
}

@end
