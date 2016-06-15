#import <Foundation/Foundation.h>
#import "ContactAddController.h"
#import "MHTabBarController.h"
#import "ContactController.h"
#import "Contact.h"

@implementation ContactAddController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@ viewDidLoad", self.title);
    NSArray *views=[[NSBundle mainBundle]loadNibNamed:@"AddContact" owner:nil options:nil];
    self.contact=(AddContact *)[views lastObject];
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav=self.navigationController.navigationBar.frame;
    CGRect frame=[UIScreen mainScreen].bounds;
    CGRect rect=CGRectMake(0, rectNav.size.height+rectStatus.size.height, frame.size.width, frame.size.height-rectNav.size.height-rectStatus.size.height);
    self.contact.frame=rect;
    [self.contact.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchDown];
    self.contact.message.layer.borderWidth=1.0;
    self.contact.message.layer.borderColor=[[UIColor grayColor]CGColor];
    [self.view addSubview:self.contact];
}

-(void)addBtnClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
    //    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:6];
    NSString *text=self.contact.message.text;
    Contact *ccc=[[Contact alloc]initWithMessageName:text image:@"contact.png"];
    MHTabBarController *mhtabController=(MHTabBarController *)[self.navigationController visibleViewController];
    ContactController *contactController=(ContactController *)mhtabController.selectedViewController;
    [contactController updateData:ccc];
}

@end
