
#ifndef Group_h
#define Group_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic,strong) NSString *groupname;
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSMutableArray *members;

- (id)initWithMessageName:(NSString *)con messageTitle:(NSString *)time messageMembers:(NSMutableArray *)mems;

@end

#endif /* Group_h */
