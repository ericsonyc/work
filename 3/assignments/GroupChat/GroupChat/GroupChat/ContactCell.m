#import <Foundation/Foundation.h>
#import "ContactCell.h"

@implementation ContactCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentLabel.font=[UIFont fontWithName:@"Arial" size:15];
    }
    return self;
}

-(void)setupCell:(Contact *)message{
    self.contentLabel.text=message.name;
    
    self.imageView.image=[UIImage imageNamed:message.imageUrl];
}

@end
