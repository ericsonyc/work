#import <Foundation/Foundation.h>
#import "GroupCell.h"

@implementation GroupCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
    }
    return self;
}

-(void)setupCell:(Group *)message{
    self.groupnameLabel.font=[UIFont fontWithName:@"Arial" size:15];
    self.membersLabel.font=[UIFont fontWithName:@"Arial" size:15];
    self.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    self.groupnameLabel.text=message.groupname;
    self.titleLabel.text=message.title;
    NSString *temp=@"";
    for (int i=0; i<[message.members count]; i++) {
        temp=[temp stringByAppendingString:message.members[i]];
        temp=[temp stringByAppendingString:@" "];
    }
    self.membersLabel.text=temp;
}

@end