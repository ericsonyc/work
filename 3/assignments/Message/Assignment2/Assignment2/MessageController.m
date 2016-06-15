
#import <Foundation/Foundation.h>
#import "MessageController.h"
#import "MHTabBarController.h"
#import "Message.h"
#import "MessageCell.h"

@implementation MessageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@ viewDidLoad", self.title);
    self.dataList=[NSMutableArray arrayWithCapacity:6];
//    [self reloadData];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

@end