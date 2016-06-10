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
    
    
    //self.tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);

    /*
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x,
                                                                 self.view.bounds.origin.y,
                                                                 self.view.bounds.size.width,
                                                                 kHeaderHeight)];
    headerView.backgroundColor  = [UIColor redColor];
    [self.view addSubview:headerView];
    [self.view bringSubviewToFront:headerView];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewsDictionary = @{@"headerView":headerView};
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headerView]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[headerView]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    NSLayoutConstraint *constraint_HEIGHT = [NSLayoutConstraint constraintWithItem:headerView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:kHeaderHeight];
    [self.view addConstraints:constraint_POS_V];
    [self.view addConstraints:constraint_POS_H];
    [self.view addConstraint:constraint_HEIGHT];
    
    self.headerView = headerView;
    self.headerHeightConstraint = constraint_HEIGHT;
     */
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
    
    //CGFloat translateY = (scaleFactor - 1.0) * self.headerInfoBoxView.frame.size.height;
    CGAffineTransform headerInfoBoxTransform = CGAffineTransformScale(CGAffineTransformIdentity, scaleFactor, scaleFactor);

    /*
    headerInfoBoxTransform = CGAffineTransformTranslate(headerInfoBoxTransform,
                                                                          0,
                                                                          translateY);
     */
    //self.headerInfoBoxView.layer.anchorPoint = CGPointMake( self.headerInfoBoxView.layer.bounds.size.width / 2.0, 0.0);

    //self.headerInfoBoxView.layer.anchorPoint = CGPointMake(0.5, 0.0);
    self.headerInfoBoxView.transform = headerInfoBoxTransform;
    //self.headerInfoBoxView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    self.headerInfoBoxView.alpha = scaleFactor;
    
    
    //photoTitleTransform = CGAffineTransformScale(photoTitleTransform, scaleFactor, scaleFactor);
    
    //CGAffineTransformScale(CGAffineTransformIdentity, scaleFactor, scaleFactor);
    //photoTitleTransform = CGAffineTransformTranslate(photoTitleTransform, 0, self.headerPhotoSpacingFromStoryboard - (scaleFactor * self.headerPhotoSpacingFromStoryboard));
    
    //self.headerPhoto.transform = photoTitleTransform;
    //self.headerTitle.transform = photoTitleTransform;
    //self.headerPhotoTopSpacingConstraint.constant = self.headerPhotoSpacingFromStoryboard * scaleFactor;
    //self.headerTitleTopSpacingConstraint.constant = self.headerTitleSpacingFromStoryboard * scaleFactor;

    static CGFloat progressBarAndNTButtonPadding = 14.0;
    
    CGFloat progressBarTrailingSpaceDeltaAfterCollapse = self.headerNTButton.frame.size.width + progressBarAndNTButtonPadding;
    CGFloat progressBarTrailingSpaceDeltaScaled = progressBarTrailingSpaceDeltaAfterCollapse * (1.0 - scaleFactor);
    CGFloat progressBarTrailingSpace = self.progressBarTrailingSpacingFromStoryboard + progressBarTrailingSpaceDeltaScaled;
    self.progressBarTrailingSpacingConstraint.constant = progressBarTrailingSpace;
    
    
    
    
    
#undef ENABLE_TAB_COLLAPSE
#ifdef ENABLE_TAB_COLLAPSE
    // prevent collapse/restore on bounce...
    // top:
    if (scrollView.contentOffset.y <= -self.headerVisibleAfterCollapseView.frame.size.height) return;
    // bottom:
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height) return;
    
    
    //static CGFloat minimumYOffset = 50;
    
    static CGFloat mimimumMovement = 10;
    
    if ([self.parentViewController isKindOfClass:[DashboardTabViewController class]]) {
        DashboardTabViewController *dtvc = (DashboardTabViewController *)self.parentViewController;
        static BOOL animated = YES;
        if (scrollView.contentOffset.y <= 0.0) {
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
