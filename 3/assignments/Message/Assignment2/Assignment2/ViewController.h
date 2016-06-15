//
//  ViewController.h
//  Assignment2
//
//  Created by ericson on 16/5/2.
//  Copyright © 2016年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (strong,nonatomic) NSMutableArray *list;
@property (nonatomic,retain) UITableView *  timeTableView;

@property (nonatomic,retain) UIButton *addBtn;

@end

