
#import <Foundation/Foundation.h>
#import "Group.h"

@implementation Group

- (id)initWithMessageName:(NSString *)con messageTitle:(NSString *)time messageMembers:(NSMutableArray *)mems{
    self=[super init];
    if(self){
        self.groupname=con;
        self.title=time;
        self.members=[mems mutableCopy];
    }
    return self;
}
@end