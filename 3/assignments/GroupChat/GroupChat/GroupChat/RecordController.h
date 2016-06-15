
#ifndef RecordController_h
#define RecordController_h

#import<UIKit/UIKit.h>
@interface RecordController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray *searchDatas;

@property (nonatomic,strong) UISearchController *searchController;

@end

#endif /* RecordController_h */
