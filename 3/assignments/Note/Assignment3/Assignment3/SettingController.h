//
//  SettingController.h
//  Assignment3
//
//  Created by ericson on 16/5/5.
//  Copyright © 2016年 student. All rights reserved.
//

#ifndef SettingController_h
#define SettingController_h

#import <UIKit/UIKit.h>

@interface SettingController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,retain) UITableView *tableView;

@end

#endif /* SettingController_h */
