//
//  ViewController.m
//  Assignment2
//
//  Created by ericson on 16/5/2.
//  Copyright © 2016年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.list=[[NSMutableArray alloc]initWithCapacity:6];
    [self reloadData];
    CGFloat buttonHeight=40;
    CGRect rect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, buttonHeight);
    self.addBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.addBtn.frame=rect;
    
    //    button.titleLabel.textColor=[UIColor blackColor];
    [self.addBtn setTitle:@"add an expression" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addBtn.backgroundColor=[UIColor whiteColor];
    [self.addBtn addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.addBtn];
//    self.addBtn=[[UIButton alloc]initWithFrame:rect];
//    self.addBtn.titleLabel.text=@"add an expression";
//    self.addBtn.titleLabel.textColor=[UIColor blackColor];
//    self.addBtn.backgroundColor=[UIColor whiteColor];
    rect.origin.y=buttonHeight;
    rect.size.height=[UIScreen mainScreen].bounds.size.height-buttonHeight;
    self.timeTableView=[[UITableView alloc]initWithFrame:rect];
    self.timeTableView.delegate=self;
    self.timeTableView.dataSource=self;
    
    [[self view]addSubview:self.timeTableView];
}

-(void)TouchDown{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"expression" message:@" " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField * txt = [[UITextField alloc] init];
    txt.backgroundColor = [UIColor whiteColor];
    txt.frame = CGRectMake(alert.center.x+65,alert.center.y+48, 150,23);
    [alert addSubview:txt];
    [alert show];
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Expression" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UITextField * txt = [[UITextField alloc] init];
//    txt.backgroundColor = [UIColor whiteColor];
//    txt.frame = CGRectMake(alertController.view.center.x+65,alertController.view.center.y+48, 150,23);
//    
//    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:ok];
//    [alertController.view addSubview:txt];
//    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *tf=[alertView textFieldAtIndex:0];
    NSString *btnTitle=[alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"OK"]) {
        [self.list addObject:tf.text];
    }
    [self.timeTableView reloadData];
}

-(void)reloadData{
    [self.list addObject:@"I'm in a meeting."];
    [self.list addObject:@"Getting Ready For a Journey."];
    [self.list addObject:@"Call you back later."];
    [self.list addObject:@"Please call me later"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"message count: %d",[_messageDatas count]);
    return [self.list count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.list removeObjectAtIndex:indexPath.row];
        //        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.timeTableView reloadData];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
