//
//  ViewController.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "LullyTabViewController.h"

@interface LullyTabViewController ()

//@property (strong, nonatomic) IBOutlet UIView *containerView;

@end

@implementation LullyTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
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
        NSLog(@"Set vc: %@", vc);
    }
}

@end
