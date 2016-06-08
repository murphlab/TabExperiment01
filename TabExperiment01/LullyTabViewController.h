//
//  ViewController.h
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LullyTabViewController : UIViewController

@property (weak, nonatomic) UIViewController *displayedViewController;

- (void)selectViewControllerWithIndex:(NSUInteger)index;

- (void)displayContentController:(UIViewController*)content;


@end

