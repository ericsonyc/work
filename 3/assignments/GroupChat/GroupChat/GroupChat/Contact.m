#import <Foundation/Foundation.h>
#import "Contact.h"

@implementation Contact

- (id)initWithMessageName:(NSString *)con image:(NSString *)image{
    self=[super init];
    if(self){
        self.name=con;
        self.imageUrl=image;
    }
    return self;
}

@end