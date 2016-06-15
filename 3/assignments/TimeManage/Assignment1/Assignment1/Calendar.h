//
//  Calendar.h
//  Assignment1
//
//  Created by ericson on 16/5/2.
//  Copyright © 2016年 student. All rights reserved.
//

#ifndef Calendar_h
#define Calendar_h

#import <UIKit/UIKit.h>
#import "LGCalendar.h"

@interface Calendar : UIViewController<UITextFieldDelegate, LGCalendarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) LGCalendar *LGCalendar;

- (IBAction)click;

@end

#endif /* Calendar_h */
