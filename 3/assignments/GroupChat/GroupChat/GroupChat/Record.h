

#ifndef Record_h
#define Record_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Record : NSObject

@property (nonatomic,assign) NSString *content;
@property (nonatomic,assign) NSString *date;

- (id)initWithMessageContent:(NSString *)con messageDate:(NSString *)time;

@end

#endif /* Record_h */
