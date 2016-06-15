//
//  Calendar.m
//  Assignment1
//
//  Created by ericson on 16/5/2.
//  Copyright © 2016年 student. All rights reserved.
//

#import "Calendar.h"

@interface Calendar ()

@end

@implementation Calendar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LGCalendar *calendar = [[LGCalendar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 240)];
    [self.view addSubview:calendar];
    calendar.delegate = self;
    self.LGCalendar = calendar;
    
}

-(void)LGCalendar:(LGCalendar *)calendar didSelectDate:(NSDate *)selectDate
{
    NSLog(@"select date:%@", selectDate);
//    [self.textField setText:[NSString stringWithFormat:@"%@", selectDate]];
}



- (IBAction)click {
    [self.LGCalendar setCurrentDate:[NSDate date]];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end