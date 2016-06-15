
#ifndef AddView_h
#define AddView_h

#import <UIKit/UIKit.h>

@interface AddView: UIView

@property (nonatomic,strong) IBOutlet UITextField *groupField;
@property (nonatomic,strong) IBOutlet UITextView *memField;
@property (nonatomic,strong) IBOutlet UIButton *addBtn;

@end

#endif /* AddView_h */
