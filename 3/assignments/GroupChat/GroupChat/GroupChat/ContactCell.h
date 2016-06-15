
#ifndef ContactCell_h
#define ContactCell_h

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactCell:UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *contentLabel;
@property (strong,nonatomic) IBOutlet UIImageView *imageView;

-(void)setupCell:(Contact *)message;

@end

#endif /* ContactCell_h */
