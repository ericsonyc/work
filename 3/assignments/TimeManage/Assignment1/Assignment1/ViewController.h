//
//  ViewController.h
//  Assignment1
//
//  Created by ericson on 16/5/1.
//  Copyright © 2016年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scheduler.h"
#import "Calendar.h"
#import "Plan.h"
#import "CTWeekViewController.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSArray *list;
@property (nonatomic,retain) UITableView *  timeTableView;
@property (nonatomic,strong) Scheduler *scheduleController;
@property (nonatomic,strong) Calendar *calendarController;
@property (nonatomic,strong) Plan *planController;

@property (nonatomic,strong) CTWeekViewController *weekController;
@end

