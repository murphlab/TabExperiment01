//
//  TestSubclassLullyTabViewController.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "TestSubclassLullyTabViewController.h"

@interface TestSubclassLullyTabViewController ()

@end

@implementation TestSubclassLullyTabViewController

- (void)viewDidLoad {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *favoritesVC = [sb instantiateViewControllerWithIdentifier:@"Favorites"];
    UIViewController *featuredVC = [sb instantiateViewControllerWithIdentifier:@"Featured"];
    self.viewControllers = @[ favoritesVC, featuredVC ];
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
