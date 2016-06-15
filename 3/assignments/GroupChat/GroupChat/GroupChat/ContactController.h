
#ifndef ContactController_h
#define ContactController_h

#import<UIKit/UIKit.h>
#import "SearchView.h"
#import "Contact.h"
@interface ContactController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray *searchDatas;
@property (nonatomic,strong) SearchView *search;
@property (nonatomic) BOOL searchflag;

@property (nonatomic,strong) UISearchController *searchController;

-(void)updateData:(Contact *)contact;
@end

#endif /* ContactController_h */
