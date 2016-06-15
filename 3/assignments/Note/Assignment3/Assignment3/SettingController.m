//
//  SettingController.m
//  Assignment3
//
//  Created by ericson on 16/5/5.
//  Copyright © 2016年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingController.h"
#import "Message.h"
#import "GroupMessage.h"

@implementation SettingController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    CGRect frame=[[UIScreen mainScreen] bounds];
    self.tableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.datas=[[NSMutableArray alloc]initWithCapacity:6];
    [self loadData];
    [self.view addSubview:self.tableView];
}

-(void)loadData{
    Message *message1=[[Message alloc]initWithName:@"Check Update"];
    Message *message2=[[Message alloc]initWithName:@"Feedback"];
    NSMutableArray *array1=[[NSMutableArray alloc]initWithObjects:message1,message2, nil];
    GroupMessage *group1=[[GroupMessage alloc]initWithGroupName:@"Setting" MessageArray:array1];
    
    Message *message3=[[Message alloc]initWithName:@"Twitter"];
    Message *message4=[[Message alloc]initWithName:@"Facebook"];
    Message *message5=[[Message alloc]initWithName:@"Email"];
    NSMutableArray *array2=[[NSMutableArray alloc]initWithObjects:message3,message4,message5, nil];
    GroupMessage *group2=[[GroupMessage alloc]initWithGroupName:@"Contact us" MessageArray:array2];
    
    [self.datas addObject:group1];
    [self.datas addObject:group2];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.datas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"message count: %d",[_messageDatas count]);
    GroupMessage *group=[self.datas objectAtIndex:section];
    return [group.messageArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *messageCell=@"messageCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:messageCell];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageCell];
    }
    GroupMessage *group=self.datas[indexPath.section];
    Message *message=group.messageArray[indexPath.row];
    cell.textLabel.text=message.name;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    GroupMessage *group=self.datas[section];
    return group.groupName;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@, parent is %@", self.title, self.parentViewController);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end