
#import <Foundation/Foundation.h>
#import "RecordController.h"
#import "RecordCell.h"
#import "Record.h"

@implementation RecordController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.datas=[[NSMutableArray alloc]initWithCapacity:6];
    self.searchDatas=[[NSMutableArray alloc]initWithCapacity:6];
    CGRect rectStatus=[[UIApplication sharedApplication]statusBarFrame];
//    CGRect rectNav=self.navigationController.navigationBar.frame;
    
    CGRect frame=[[UIScreen mainScreen] bounds];
    CGRect rect=CGRectMake(0, rectStatus.origin.y, frame.size.width, frame.size.height-rectStatus.size.height);
    self.tableView=[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    
    _searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController.searchBar sizeToFit];
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    CGRect searchrect=CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    _searchController.searchBar.frame = searchrect;
    
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self loadData];
    [self.view addSubview:self.tableView];
}

-(void)loadData{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy/M/d"];
    Record *record1=[[Record alloc]initWithMessageContent:@"This is record one." messageDate:[formatter stringFromDate:[NSDate date]]];
    Record *record2=[[Record alloc]initWithMessageContent:@"This is record two." messageDate:[formatter stringFromDate:[NSDate date]]];
    
    [self.datas addObject:record1];
    [self.datas addObject:record2];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self.searchDatas removeAllObjects];
    NSString *pattern=@"\\S*";
    pattern=[pattern stringByAppendingFormat:@"%@\\S*",self.searchController.searchBar.text];
    NSRegularExpression *reg=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSRegularExpression *reg1=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSMutableArray *list=[[NSMutableArray alloc]initWithCapacity:6];
    for (int i=0; i<[self.datas count]; i++) {
        Record *record=[self.datas objectAtIndex:i];
        NSArray* match = [reg matchesInString:record.content options:NSMatchingCompleted range:NSMakeRange(0, [record.content length])];
        if (match.count>0) {
            [list addObject:record];
            continue;
        }
        match=[reg1 matchesInString:record.date options:NSMatchingCompleted range:NSMakeRange(0, [record.date length])];
        if (match.count>0) {
            [list addObject:record];
            continue;
        }
    }
    //    NSMutableArray *List=[self.searchList mutableCopy];
    self.searchDatas=[list mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"message count: %d",[_messageDatas count]);
    if (self.searchController.active) {
        return [self.searchDatas count];
    }else{
        return [self.datas count];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *messageCell=@"messageCell";
    RecordCell *cell=[tableView dequeueReusableCellWithIdentifier:messageCell];
    if(cell==nil){
        NSArray *views=[[NSBundle mainBundle]loadNibNamed:@"RecordCell" owner:nil options:nil];
        cell=(RecordCell *)[views lastObject];
    }
    Record *record;
    if (self.searchController.active) {
        record=(Record *)self.searchDatas[indexPath.row];
    }else{
        record=(Record *)self.datas[indexPath.row];
    }
    cell.contentLabel.text=record.content;
    cell.contentLabel.font=[UIFont fontWithName:@"Arial" size:15];
    
    cell.timeLabel.text=record.date;
    cell.timeLabel.font=[UIFont fontWithName:@"Arial" size:15];
    
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