
#ifndef GroupCell_h
#define GroupCell_h

#import <UIKit/UIKit.h>
#import "Group.h"

@interface GroupCell:UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *groupnameLabel;
@property (strong,nonatomic) IBOutlet UILabel *membersLabel;
@property (strong,nonatomic) IBOutlet UILabel *titleLabel;

-(void)setupCell:(Group *)message;

@end

#endif /* GroupCell_h */
