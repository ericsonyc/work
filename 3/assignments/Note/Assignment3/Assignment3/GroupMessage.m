//
//  GroupMessage.m
//  Assignment3
//
//  Created by ericson on 16/5/5.
//  Copyright © 2016年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupMessage.h"

@implementation GroupMessage

-(id)initWithGroupName:(NSString *)name MessageArray:(NSMutableArray *)array{
    self.groupName=name;
    self.messageArray=array;
    return self;
}

@end