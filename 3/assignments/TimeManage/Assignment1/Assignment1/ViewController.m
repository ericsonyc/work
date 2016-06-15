//
//  ViewController.m
//  Assignment1
//
//  Created by ericson on 16/5/1.
//  Copyright © 2016年 student. All rights reserved.
//

#import "ViewController.h"
#import "DDClock.h"
#import "Scheduler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DDClock *clock1 = [[DDClock alloc] initWithTheme:DDClockThemeDark position:CGPointMake(([UIScreen mainScreen].bounds.size.width - 200 )/2, 70)];
    CGFloat clockHeight=clock1.frame.size.height+20;
    
    [[self view] addSubview:clock1];
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGRect frame=CGRectMake(0, clockHeight+10+50, width, 40);
    UILabel *manageTime=[[UILabel alloc] initWithFrame:frame];
    manageTime.text=@"Manage your time";
    manageTime.textColor=[UIColor blackColor];
    manageTime.textAlignment=NSTextAlignmentCenter;
    [[self view]addSubview:manageTime];
    
    NSArray *array=[[NSArray alloc]initWithObjects:@"Curriculum Schedule",@"Calendar",@"Plan", nil];
    self.list=array;
    CGRect tableRect=CGRectMake(0, clockHeight+100, width, 40*self.list.count);
    self.timeTableView=[[UITableView alloc]initWithFrame:tableRect];
    self.timeTableView.delegate=self;
    self.timeTableView.dataSource=self;
    
    [[self view]addSubview:self.timeTableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //number of sections
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //number rows of each section
    return [self.list count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell type for each row
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.list objectAtIndex:row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //if select the row, it calls this function
    switch (indexPath.row) {
        case 0:
//            if (self.scheduleController==nil) {
//                self.scheduleController=[[Scheduler alloc]init];
//            }
//            [[self navigationController] pushViewController:self.scheduleController animated:YES];
            if (self.weekController==nil) {
                self.weekController=[[CTWeekViewController alloc]init];
            }
            [[self navigationController] pushViewController:self.weekController animated:YES];
            break;
        case 1:
            if (self.calendarController==nil) {
                self.calendarController=[[Calendar alloc]init];
            }
            [[self navigationController] pushViewController:self.calendarController animated:YES];
            break;
        case 2:
            if (self.planController==nil) {
                self.planController=[[Plan alloc]init];
            }
            [[self navigationController]pushViewController:self.planController animated:YES];
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
