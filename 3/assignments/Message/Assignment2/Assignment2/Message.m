//
//  Message.m
//  Assignment2
//
//  Created by ericson on 16/5/3.
//  Copyright © 2016年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Message.h"

@implementation Message

-(id)initWithMessageNumber:(NSString *)num messageDate:(NSString *)time messageContent:(NSString *)neirong messageImage:(UIImage *)image{
    self=[super init];
    if (self) {
        self.number=num;
        self.nowTime=time;
        self.content=neirong;
        self.portrait=image;
    }
    return self;
}

@end