//
//  FavoritesViewController.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/7/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "FavoritesViewController.h"
#import "DashboardTabViewController.h"

@interface FavoritesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *headerInfoBoxView;
@property (weak, nonatomic) IBOutlet UIView *headerNTButton;
@property (weak, nonatomic) IBOutlet UIView *headerVisibleAfterCollapseView;
@property (weak, nonatomic) IBOutlet UIView *headerDummyProgressBarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CGFloat lastYOffset;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTopSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressBarTrailingSpacingConstraint;

@property (nonatomic) CGFloat headerHeightFromStoryboard;
@property (nonatomic) CGFloat progressBarTrailingSpacingFromStoryboard;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"FavoritesViewController: viewDidLoad");
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // The storyboard is where we get the default height of the header:
    self.headerHeightFromStoryboard = self.headerHeightConstraint.constant;
    
    // capture original tailing spacing as this will be adjusted dynamically as well:
    self.progressBarTrailingSpacingFromStoryboard = self.progressBarTrailingSpacingConstraint.constant;
    
    // Modify storyboard layout of table, pinning tableView to top of root view (under the header):
    self.tableTopSpacingConstraint.constant = 0.0;
    
    // Set content inset to push top of table contents out from under header:
    self.tableView.contentInset = UIEdgeInsetsMake(self.headerHeightFromStoryboard, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"FavoritesViewController: viewDidAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate (and therefore scroll view delegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"SCROLL! %g", scrollView.contentOffset.y);
    
    CGFloat headerHeightAdj = 0 - scrollView.contentOffset.y;
    headerHeightAdj = MIN(self.headerHeightFromStoryboard, headerHeightAdj);
    headerHeightAdj = MAX(self.headerVisibleAfterCollapseView.frame.size.height, headerHeightAdj);
    self.headerHeightConstraint.constant = headerHeightAdj;
    
    CGFloat scaleFactor = (headerHeightAdj - self.headerVisibleAfterCollapseView.frame.size.height) / (self.headerHeightFromStoryboard - self.headerVisibleAfterCollapseView.frame.size.height);
    //NSLog(@"scaleFactor: %g", scaleFactor);
    CGAffineTransform headerInfoBoxTransform = CGAffineTransformScale(CGAffineTransformIdentity, scaleFactor, scaleFactor);

    self.headerInfoBoxView.transform = headerInfoBoxTransform;
    self.headerInfoBoxView.alpha = scaleFactor;
    
    static CGFloat progressBarAndNTButtonPadding = 14.0;
    
    CGFloat progressBarTrailingSpaceDeltaAfterCollapse = self.headerNTButton.frame.size.width + progressBarAndNTButtonPadding;
    CGFloat progressBarTrailingSpaceDeltaScaled = progressBarTrailingSpaceDeltaAfterCollapse * (1.0 - scaleFactor);
    CGFloat progressBarTrailingSpace = self.progressBarTrailingSpacingFromStoryboard + progressBarTrailingSpaceDeltaScaled;
    self.progressBarTrailingSpacingConstraint.constant = progressBarTrailingSpace;
    
#define ENABLE_TAB_COLLAPSE
#ifdef ENABLE_TAB_COLLAPSE
    
    if ([self.parentViewController isKindOfClass:[DashboardTabViewController class]]) {
        
        CGFloat topContentOffset = -self.headerVisibleAfterCollapseView.frame.size.height;
        
        // prevent collapse/restore on bounce...
        // top:
        if (scrollView.contentOffset.y <= topContentOffset) return;
        // bottom:
        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height) return;
        
        static CGFloat mimimumMovement = 1;
        
        DashboardTabViewController *dtvc = (DashboardTabViewController *)self.parentViewController;
        static BOOL animated = YES;
        if (scrollView.contentOffset.y <= topContentOffset) {
            [dtvc setBarCollapsed:NO animated:animated]; // always un-collapse if scrolled to the top
        } else if (fabs(scrollView.contentOffset.y - self.lastYOffset) < mimimumMovement) {
            return;
        } else {
            [dtvc setBarCollapsed:scrollView.contentOffset.y > self.lastYOffset animated:animated];
        }
    }
    self.lastYOffset = scrollView.contentOffset.y;
#endif
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dummyCell" forIndexPath:indexPath];
    return cell;
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
