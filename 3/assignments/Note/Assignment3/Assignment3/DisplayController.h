//
//  DisplayController.h
//  Assignment3
//
//  Created by ericson on 16/5/5.
//  Copyright © 2016年 student. All rights reserved.
//

#ifndef DisplayController_h
#define DisplayController_h

#import <UIKit/UIKit.h>
#import "Note.h"

@interface DisplayController : UIViewController

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *datelabel;
@property (nonatomic,strong) UILabel *likelabel;
@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic,strong) Note *note;

-(void)passMessage:(Note *)nn;
@end

#endif /* DisplayController_h */
