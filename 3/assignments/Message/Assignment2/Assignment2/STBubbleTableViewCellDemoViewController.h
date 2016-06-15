//
//  STBubbleTableViewCellDemoViewController.h
//  STBubbleTableViewCellDemo
//
//  Created by Cedric Vandendriessche on 24/08/13.
//  Copyright 2013 FreshCreations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface STBubbleTableViewCellDemoViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

-(void)loadData:(Message*)message;

@end
