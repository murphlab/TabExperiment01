//
//  DashboardTabViewController.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "DashboardTabViewController.h"

@interface DashboardTabViewController ()

@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIButton *favoritesButton;
@property (weak, nonatomic) IBOutlet UIButton *featuredButton;
@property (weak, nonatomic) IBOutlet UIButton *navButton;

@property (strong, nonatomic) NSMutableArray *vcIndex;
@property (strong, nonatomic) NSMutableArray *buttonIndex;

@property (weak, nonatomic) UIViewController *displayedViewController;

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
    
    UIViewController *navVC = [sb instantiateViewControllerWithIdentifier:@"Nav"];
    [self.vcIndex addObject:navVC];
    [self.buttonIndex addObject:self.navButton];
    
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

- (void)updateButtons
{
    for (NSUInteger i = 0; i < self.buttonIndex.count; i++) {
        UIButton *btn = self.buttonIndex[i];
        UIViewController *vc = self.vcIndex[i];
        btn.selected = [vc isEqual:self.displayedViewController];
    }
}



@end
