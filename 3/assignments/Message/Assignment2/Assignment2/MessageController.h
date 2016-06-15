
#ifndef MessageController_h
#define MessageController_h

#import <UIKit/UIKit.h>
@interface MessageController : UITableViewController

@property (strong,nonatomic) NSMutableArray *dataList;
@property (strong,nonatomic) NSMutableArray *searchList;
@property (nonatomic,retain) UITableView *  timeTableView;
@property (nonatomic,strong) UISearchController *searchController;

@end

#endif /* MessageController_h */
