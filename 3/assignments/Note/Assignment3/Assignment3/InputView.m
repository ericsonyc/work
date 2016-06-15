
#import <Foundation/Foundation.h>
#import "InputView.h"

@implementation InputView

-(void)setup:(NSString *)date like:(BOOL)like{
    self.dateLabel.text=date;
    self.text.text=@"Like";
    if (like) {
        [self.likeornot setOn:YES];
    }else{
        [self.likeornot setOn:NO];
    }
    
}

-(id)getValue{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy/M/d HH:mm"];
    Note *note=[[Note alloc]initWithMessage:self.textView.text Date:[formatter dateFromString:self.dateLabel.text] like:self.likeornot.isOn];
    return note;
}

@end