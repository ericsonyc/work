//
//  GroupMessage.h
//  Assignment3
//
//  Created by ericson on 16/5/5.
//  Copyright © 2016年 student. All rights reserved.
//

#ifndef GroupMessage_h
#define GroupMessage_h

#import <UIKit/UIKit.h>

@interface GroupMessage : NSObject

@property (nonatomic,strong) NSString *groupName;
@property (nonatomic,strong) NSMutableArray *messageArray;

-(id)initWithGroupName:(NSString *)name MessageArray:(NSMutableArray *)array;
@end

#endif /* GroupMessage_h */
