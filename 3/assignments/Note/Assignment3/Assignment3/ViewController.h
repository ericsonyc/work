
#import <UIKit/UIKit.h>
#import "Note.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) NSMutableArray *notedatas;
@property (nonatomic,strong) NSMutableArray *searchnotes;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UISearchController *searchController;

@property (nonatomic,strong) NSString *formatString;

-(void)updateData:(Note *)note;

@end

