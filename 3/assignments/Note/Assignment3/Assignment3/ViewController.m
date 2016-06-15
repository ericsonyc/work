//
//  ViewController.m
//  Assignment3
//
//  Created by ericson on 16/5/5.
//  Copyright © 2016年 student. All rights reserved.
//

#import "ViewController.h"
#import "SettingController.h"
#import "AddController.h"
#import "DisplayController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect=[[UIScreen mainScreen] bounds];
    self.tableView=[[UITableView alloc]initWithFrame:rect];
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    
    _searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController.searchBar sizeToFit];
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.notedatas=[[NSMutableArray alloc]initWithCapacity:6];
    
    self.formatString=@"yyyy/M/d HH:mm";
    [self loadData];
    [self sortDates];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithTitle:@"Setting" style:UIBarButtonItemStylePlain target:self action:@selector(selectLeftButton:)];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selectRightButton:)];
    self.navigationItem.rightBarButtonItem=rightButton;
    [self.view addSubview:self.tableView];
}

-(void)updateData:(Note *)note{
    Note *temp=[[Note alloc]initWithMessage:note.message Date:note.date like:note.switchLike];
    [self.notedatas addObject:temp];
    [self sortDates];
    [self.tableView reloadData];
}

-(void)selectLeftButton:(id)sender{
    SettingController *setting=[[SettingController alloc]init];
//    self.navigationItem.leftBarButtonItem.title=@"Back";
    [self.navigationController pushViewController:setting animated:YES];
}

-(void)selectRightButton:(id)sender{
    AddController *addcontroller=[[AddController alloc]init];
    [self.navigationController pushViewController:addcontroller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : self.formatString];
    NSString *stringTime=@"2016/5/3 14:50";
    NSDate *temp=[formatter dateFromString:stringTime];
    Note *note1=[[Note alloc]initWithMessage:@"This is note one!" Date:temp like:YES];
    [self.notedatas addObject:note1];
    
    stringTime=@"2016/5/4 07:20";
    temp=[formatter dateFromString:stringTime];
    Note *note2=[[Note alloc]initWithMessage:@"This is note two!" Date:temp like:NO];
    [self.notedatas addObject:note2];
    
    stringTime=@"2016/5/3 13:10";
    temp=[formatter dateFromString:stringTime];
    Note *note3=[[Note alloc]initWithMessage:@"This is note three!" Date:temp like:NO];
    [self.notedatas addObject:note3];
}

-(void)sortDates{
    NSMutableArray *tempdatas=[[NSMutableArray alloc]initWithCapacity:6];
    for (int i=0; i<[self.notedatas count]; i++) {
        Note *note=self.notedatas[i];
        int j=0;
        for (; j<[tempdatas count]; j++) {
            Note *temp=tempdatas[j];
            NSComparisonResult result=[note.date compare:temp.date];
            if (result==NSOrderedDescending) {
                break;
            }
        }
        [tempdatas insertObject:note atIndex:j];
    }
    self.notedatas=[tempdatas mutableCopy];
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self.searchnotes removeAllObjects];
    NSString *pattern=@"\\S*";
    pattern=[pattern stringByAppendingFormat:@"%@\\S*",self.searchController.searchBar.text];
    NSRegularExpression *reg=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSMutableArray *list=[[NSMutableArray alloc]initWithCapacity:6];
    for (int i=0; i<[self.notedatas count]; i++) {
        Note *note=[self.notedatas objectAtIndex:i];
        NSArray* match = [reg matchesInString:note.message options:NSMatchingCompleted range:NSMakeRange(0, [note.message length])];
        if (match.count>0) {
            [list addObject:note];
        }
    }
    //    NSMutableArray *List=[self.searchList mutableCopy];
    self.searchnotes=[list mutableCopy];
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
        return [self.searchnotes count];
    }else
        return [self.notedatas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *messageCell=@"messageCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:messageCell];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:messageCell];
    }
    if([cell.subviews count]<=1){
        CGRect rect=cell.frame;
        CGRect frame=CGRectMake(rect.size.width-60, rect.size.height/2-15, 50, 30);
        UISwitch *swi=[[UISwitch alloc]initWithFrame:frame];
        swi.tag=indexPath.row;
        [swi addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:swi];
    }
    
    if (self.searchController.active) {
        Note *note=(Note *)self.searchnotes[indexPath.row];
        cell.textLabel.text=note.message;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        
        [formatter setTimeZone:timeZone];
        [formatter setDateFormat : self.formatString];
        cell.detailTextLabel.text=[formatter stringFromDate:note.date];
        UISwitch *swi=(UISwitch *)[cell.subviews objectAtIndex:1];
        [swi setOn:note.switchLike];
        
    }else{
        Note *note=(Note *)self.notedatas[indexPath.row];
        cell.textLabel.text=note.message;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        
        [formatter setTimeZone:timeZone];
        [formatter setDateFormat : self.formatString];
        cell.detailTextLabel.text=[formatter stringFromDate:note.date];
        UISwitch *swi=(UISwitch *)[cell.subviews objectAtIndex:1];
        [swi setOn:note.switchLike];
    }

    return cell;
}

-(void)switchClick:(id)sender{
    UISwitch *switchView=(UISwitch *)sender;
    NSInteger row=switchView.tag;
    if (self.searchController.active) {
        ((Note *)[self.searchnotes objectAtIndex:row]).switchLike=switchView.isOn;
    }else{
        ((Note *)[self.notedatas objectAtIndex:row]).switchLike=switchView.isOn;
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.notedatas removeObjectAtIndex:indexPath.row];

        [self.tableView reloadData];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@, parent is %@", self.title, self.parentViewController);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Note *note;
    if(self.searchController.active){
        note=[self.notedatas objectAtIndex:indexPath.row];
    }else{
        note=[self.notedatas objectAtIndex:indexPath.row];
    }
    
    DisplayController *displayController=[[DisplayController alloc]init];
    
    [self.navigationController pushViewController:displayController animated:YES];
    [displayController passMessage:note];
}

-(void)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
