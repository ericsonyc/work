
#import <Foundation/Foundation.h>
#import "MessageCell.h"

@implementation MessageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
    }
    return self;
}

-(void)setupCell:(Message *)message{
    self.num_label.text=message.number;
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"M/d/yyyy h:m a"];
    
//    NSDate *dateNow = message.now;
    
//    [formatter setDateFormat : @"yyyy年M月d日 H点m分"];
//    [formatter setDateFormat:@"HH:mm:ss"];
//    NSLog(@"%@",[formatter stringFromDate:message.now]);
    
    self.time_label.text=[formatter stringFromDate:[NSDate date]];
    self.content_label.text=message.content;
    self.imageView.image=[UIImage imageNamed:@"portrait.png"];
}

@end