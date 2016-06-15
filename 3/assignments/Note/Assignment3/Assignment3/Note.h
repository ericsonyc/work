//
//  Note.h
//  Assignment3
//
//  Created by ericson on 16/5/5.
//  Copyright © 2016年 student. All rights reserved.
//

#ifndef Note_h
#define Note_h

#import <UIKit/UIKit.h>

@interface Note : NSObject

@property (nonatomic,strong) NSString *message;
@property (nonatomic,readwrite,strong) NSDate *date;
@property (nonatomic) BOOL switchLike;

-(id)initWithMessage:(NSString *)mess Date:(NSDate *)time like:(BOOL)like;
@end

#endif /* Note_h */
