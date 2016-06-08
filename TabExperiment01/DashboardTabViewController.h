//
//  DashboardTabViewController.h
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardTabViewController : UIViewController

@property (nonatomic) BOOL barCollapsed;

- (void)setBarCollapsed:(BOOL)barCollapsed animated:(BOOL)animated;

@end
