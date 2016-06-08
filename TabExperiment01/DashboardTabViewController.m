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
@property (strong, nonatomic) UIViewController *favoritesVC;
@property (strong, nonatomic) UIViewController *featuredVC;
@end

@implementation DashboardTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.favoritesVC = [sb instantiateViewControllerWithIdentifier:@"Favorites"];
    self.featuredVC = [sb instantiateViewControllerWithIdentifier:@"Featured"];
    
    [self displayContentController:self.favoritesVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favoritesButtonTapped:(id)sender {
    [self displayContentController:self.favoritesVC];

}

- (IBAction)featuredButtonTapped:(id)sender {
    [self displayContentController:self.featuredVC];
}

@end
