
#import "AddController.h"
#import "GroupController.h"
#import "Group.h"
#import "MHTabBarController.h"

@implementation AddController

- (void)viewDidLoad
{
	[super viewDidLoad];
	NSLog(@"%@ viewDidLoad", self.title);
    NSArray *views=[[NSBundle mainBundle]loadNibNamed:@"AddGroup" owner:nil options:nil];
    self.addview=(AddView *)[views lastObject];
    CGRect rectNav=self.navigationController.navigationBar.frame;
    CGRect frame=[UIScreen mainScreen].bounds;
    CGRect rect=CGRectMake(0, rectNav.size.height, frame.size.width, frame.size.height-rectNav.size.height);
    self.addview.frame=rect;
    [self.addview.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchDown];
    self.addview.memField.layer.borderWidth=1.0;
    self.addview.memField.layer.borderColor=[[UIColor grayColor]CGColor];
    [self.view addSubview:self.addview];
}

-(void)addBtnClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
//    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:6];
    NSString *text=self.addview.memField.text;
//    if ([text characterAtIndex:(text.length-1)]!='\n') {
//        text=[text stringByAppendingString:@"\n"];
//    }
    NSArray *splits=[text componentsSeparatedByString:@"\n"];
    NSString *groupname=self.addview.groupField.text;
    Group *group=[[Group alloc]initWithMessageName:groupname messageTitle:@"" messageMembers:[splits mutableCopy]];
    MHTabBarController *mhtabController=(MHTabBarController *)[self.navigationController visibleViewController];
    GroupController *groupController=(GroupController *)mhtabController.selectedViewController;
    [groupController updateData:group];
}

@end
