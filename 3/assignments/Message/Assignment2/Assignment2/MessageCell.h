//
//  MessageCell.h
//  Assignment2
//
//  Created by ericson on 16/5/3.
//  Copyright © 2016年 student. All rights reserved.
//

#ifndef MessageCell_h
#define MessageCell_h

#import <UIKit/UIKit.h>
#import "Message.h"
@interface MessageCell:UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *num_label;
@property (strong,nonatomic) IBOutlet UILabel *time_label;
@property (strong,nonatomic) IBOutlet UILabel *content_label;
@property (strong,nonatomic) IBOutlet UIImageView *imageview;

-(void)setupCell:(Message *)message;

@end

#endif /* MessageCell_h */
