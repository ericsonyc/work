
#import <Foundation/Foundation.h>
#import "GroupController.h"
#import "GroupCell.h"
#import "AddController.h"
#import "AddView.h"

@implementation GroupController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.datas=[[NSMutableArray alloc]initWithCapacity:6];
    self.searchDatas=[[NSMutableArray alloc]initWithCapacity:6];
    
    CGRect rectStatus=[[UIApplication sharedApplication]statusBarFrame];
    
    
    CGRect frame=[[UIScreen mainScreen] bounds];
    CGRect rect=CGRectMake(0, rectStatus.origin.y, frame.size.width, frame.size.height-rectStatus.size.height);
    self.tableView=[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self loadData];
    
    //uisearchcontroller
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    
    _searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController.searchBar sizeToFit];
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    NSArray *views=[[NSBundle mainBundle]loadNibNamed:@"Search" owner:nil options:nil];
    self.search=(SearchView *)[views lastObject];
    self.search.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.0f);
    self.search.searchBar.delegate=self;
    self.searchflag=NO;
    [self.search.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchDown];
//  self.search.searchBar.showsCancelButton=YES;
    
    
//  _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.search;
    
    [self.view addSubview:self.tableView];
}

-(void)updateData:(Group *)group{
    [self.datas addObject:group];
    [self.tableView reloadData];
}

-(void)addBtnClick:(id)sender{
    AddController *addGroup=[[AddController alloc]init];
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:addGroup animated:YES];
}

-(void)loadData{
    Group *contact1=[[Group alloc]initWithMessageName:@"Group1" messageTitle:@"Title1" messageMembers:[[NSMutableArray alloc]initWithObjects:@"Mem1",@"Mem2",@"Mem3", nil]];
    
    Group *contact2=[[Group alloc]initWithMessageName:@"Group2" messageTitle:@"Title2" messageMembers:[[NSMutableArray alloc]initWithObjects:@"Mem1",@"Mem2",@"Mem3", nil]];
    
    [self.datas addObject:contact1];
    [self.datas addObject:contact2];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.search.searchBar.text=@"";
    self.searchflag=NO;
    self.search.searchBar.showsCancelButton=NO;
    [self.tableView reloadData];
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *pattern=@"\\S*";
    pattern=[pattern stringByAppendingFormat:@"%@\\S*",self.search.searchBar.text];
    NSRegularExpression *reg=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSRegularExpression *reg1=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSMutableArray *list=[[NSMutableArray alloc]initWithCapacity:6];
    for (int i=0; i<[self.datas count]; i++) {
        Group *record=[self.datas objectAtIndex:i];
        NSArray* match = [reg matchesInString:record.groupname options:NSMatchingCompleted range:NSMakeRange(0, [record.groupname length])];
        if (match.count>0) {
            [list addObject:record];
            continue;
        }
        match=[reg1 matchesInString:record.title options:NSMatchingCompleted range:NSMakeRange(0, [record.title length])];
        if (match.count>0) {
            [list addObject:record];
            continue;
        }
        for (int i=0; i<[record.members count]; i++) {
            match=[reg1 matchesInString:record.members[i] options:NSMatchingCompleted range:NSMakeRange(0, [record.members[i] length])];
            if(match.count>0){
                [list addObject:record];
                break;
            }
        }
    }
    //    NSMutableArray *List=[self.searchList mutableCopy];
    self.searchDatas=[list mutableCopy];
    [self.tableView reloadData];

}

#pragma mark - UISearchResultsUpdating
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.search.searchBar.showsCancelButton=YES;
    self.searchflag=YES;
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    self.search.searchBar.showsCancelButton=NO;
    return YES;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self.searchDatas removeAllObjects];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"message count: %d",[_messageDatas count]);
    if (self.searchflag) {
         return [self.searchDatas count];
    }else{
         return [self.datas count];
    }
    
//    return [self.datas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *messageCell=@"messageCell";
    GroupCell *cell=[tableView dequeueReusableCellWithIdentifier:messageCell];
    if(cell==nil){
        NSArray *views=[[NSBundle mainBundle]loadNibNamed:@"GroupCell" owner:nil options:nil];
        cell=(GroupCell *)[views lastObject];
    }
    Group *record;
    if (self.searchflag) {
        record=(Group *)self.searchDatas[indexPath.row];
    }else{
        record=(Group *)self.datas[indexPath.row];
    }
    [cell setupCell:record];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.datas removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@, parent is %@", self.title, self.parentViewController);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end