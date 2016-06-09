//
//  FavoritesTableViewController.m
//  TabExperiment01
//
//  Created by Ken Murphy on 6/8/16.
//  Copyright © 2016 Murphlab. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "DashboardTabViewController.h"

@interface FavoritesTableViewController ()

@property (nonatomic) CGFloat lastYOffset;

@end

@implementation FavoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.tableView.bounds.size.width, 150)];
    //self.tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.lastYOffset = self.tableView.contentOffset.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
#undef ENABLE_TAB_COLLAPSE
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


/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
