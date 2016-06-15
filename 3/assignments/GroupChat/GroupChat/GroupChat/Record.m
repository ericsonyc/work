
#import <Foundation/Foundation.h>
#import "Record.h"

@implementation Record

- (id)initWithMessageContent:(NSString *)con messageDate:(NSString *)time{
    self=[super init];
    if(self){
        self.content=con;
        self.date=time;
    }
    return self;
}
@end