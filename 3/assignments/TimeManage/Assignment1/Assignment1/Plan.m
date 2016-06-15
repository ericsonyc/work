//
//  Plan.m
//  Assignment1
//
//  Created by ericson on 16/5/2.
//  Copyright © 2016年 student. All rights reserved.
//

#import "Plan.h"

@interface Plan ()

@end

@implementation Plan

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame=[UIScreen mainScreen].bounds;
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
//    self.textView.backgroundColor=[UIColor yellowColor];
    [[self view]addSubview:self.textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
