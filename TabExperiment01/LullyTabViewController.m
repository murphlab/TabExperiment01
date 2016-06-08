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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectViewControllerWithIndex:(NSUInteger)index
{
    
}

- (void) displayContentController: (UIViewController*) content {
    
    if (![self.displayedViewController isEqual:content]) {
        
        [self.displayedViewController willMoveToParentViewController:nil];
        [self.displayedViewController.view removeFromSuperview];
        [self.displayedViewController removeFromParentViewController];
        
        self.displayedViewController = content;
        [self addChildViewController:content];
        [self.containerView addSubview:content.view];
        
        content.view.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *viewsDictionary = @{@"contentView":content.view};
        NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[contentView]-0-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDictionary];
        NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentView]-0-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDictionary];
        [self.containerView addConstraints:constraint_POS_V];
        [self.containerView addConstraints:constraint_POS_H];
        
        [content didMoveToParentViewController:self];
        
    }
}

@end
