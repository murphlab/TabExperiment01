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

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CGFloat lastYOffset;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"FavoritesViewController: viewDidLoad");
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
#define ENABLE_TAB_COLLAPSE
#ifdef ENABLE_TAB_COLLAPSE
    // prevent collapse/restore on bounce...
    // top:
    if (scrollView.contentOffset.y <= 0) return;
    // bottom:
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) return;
    
    
    //static CGFloat minimumYOffset = 50;
    
    static CGFloat mimimumMovement = 10;
    
    NSLog(@"SCROLL! %g", self.tableView.contentOffset.y);
    
    if ([self.parentViewController isKindOfClass:[DashboardTabViewController class]]) {
        DashboardTabViewController *dtvc = (DashboardTabViewController *)self.parentViewController;
        static BOOL animated = YES;
        if (self.tableView.contentOffset.y <= 0.0) {
            [dtvc setBarCollapsed:NO animated:animated]; // always un-collapse if scrolled to the top
        } else if (fabs(self.tableView.contentOffset.y - self.lastYOffset) < mimimumMovement) {
            return;
        } else {
            [dtvc setBarCollapsed:self.tableView.contentOffset.y > self.lastYOffset animated:animated];
        }
    }
    self.lastYOffset = self.tableView.contentOffset.y;
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
