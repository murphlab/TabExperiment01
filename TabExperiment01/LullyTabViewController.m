//
//  ViewController.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "LullyTabViewController.h"

@interface LullyTabViewController ()

@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation LullyTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NICE TO HAVE: This app-specific stuff could be moved elsewhere to make this a generic class:
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *favoritesVC = [sb instantiateViewControllerWithIdentifier:@"Favorites"];
    UIViewController *featuredVC = [sb instantiateViewControllerWithIdentifier:@"Featured"];
    self.viewControllers = @[ favoritesVC, featuredVC ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters and setters

- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = [viewControllers copy];
    for (UIViewController *vc in _viewControllers) {
        NSLog(@"View controller title: %@", vc.title);;

    }
}

@end
