//
//  Message.h
//  Assignment3
//
//  Created by ericson on 16/5/5.
//  Copyright © 2016年 student. All rights reserved.
//

#ifndef Message_h
#define Message_h

#import <UIKit/UIKit.h>
@interface Message : NSObject

@property (nonatomic,strong) NSString *name;

-(id)initWithName:(NSString *)mm;
@end

#endif /* Message_h */
