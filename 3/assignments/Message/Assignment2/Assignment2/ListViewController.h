#import <UIKit/UIKit.h>
#import "Message-Swift.h"
@interface ListViewController : UITableViewController<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,LGChatControllerDelegate>

@property (nonatomic,strong) NSMutableArray *messageDatas;
@property (nonatomic,strong) NSMutableArray *searchList;
@property (nonatomic,strong) UISearchController *searchController;
@end
