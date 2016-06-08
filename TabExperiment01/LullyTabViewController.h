//
//  ViewController.h
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LullyTabViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;

- (void)selectViewControllerWithIndex:(NSUInteger)index;

- (void)displayContentController:(UIViewController*)content;


@end

