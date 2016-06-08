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

@property (strong, nonatomic) NSMutableArray *vcIndex;
@property (strong, nonatomic) NSMutableArray *buttonIndex;

@end

@implementation DashboardTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSUInteger numberOfTabs = 2;
    self.vcIndex = [NSMutableArray arrayWithCapacity:numberOfTabs];
    self.buttonIndex = [NSMutableArray arrayWithCapacity:numberOfTabs];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *favoritesVC = [sb instantiateViewControllerWithIdentifier:@"Favorites"];
    [self.vcIndex addObject:favoritesVC];
    [self.buttonIndex addObject:self.favoritesButton];
    
    UIViewController *featuredVC = [sb instantiateViewControllerWithIdentifier:@"Featured"];
    [self.vcIndex addObject:featuredVC];
    [self.buttonIndex addObject:self.featuredButton];
    
    [self displayContentWithIndex:0];
}

#pragma mark - Actions

- (IBAction)tabButtonTapped:(UIButton *)button
{
    NSUInteger index = [self.buttonIndex indexOfObject:button];
    if (index != NSNotFound) {
        [self displayContentWithIndex:index];
    }
}

#pragma mark - Private methods

- (void)displayContentWithIndex:(NSUInteger)index
{
    [self displayContentController:self.vcIndex[index]];
    [self updateButtons];
}

- (void)updateButtons
{
    
}

@end
