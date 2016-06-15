#import <Foundation/Foundation.h>
#import "AddController.h"
#import "Message.h"
#import "GroupMessage.h"
#import "Note.h"
#import "ViewController.h"

@implementation AddController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    CGRect rectStatus=[[UIApplication sharedApplication]statusBarFrame];
    CGRect rectNav=self.navigationController.navigationBar.frame;
    
    CGRect frame=[[UIScreen mainScreen] bounds];
    CGRect rect=CGRectMake(0, rectStatus.size.height+rectNav.size.height, frame.size.width, frame.size.height-rectStatus.size.height-rectNav.size.height);
//    InputView *inputView=[[InputView alloc]initWithFrame:rect];
    NSArray *views=[[NSBundle mainBundle]loadNibNamed:@"Input" owner:nil options:nil];
    self.inputView=(InputView *)[views lastObject];
    self.inputView.frame=rect;
    self.inputView.textView.layer.borderWidth=1.0;
    self.inputView.textView.layer.borderColor=[[UIColor grayColor]CGColor];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy/M/d HH:mm"];
    [self.inputView setup:[formatter stringFromDate:[NSDate date]] like:NO];
    
        
    [self.view addSubview:self.inputView];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonSystemItemAction target:self action:@selector(clickSave:)];
    self.navigationItem.rightBarButtonItem=rightButton;
}

-(void)clickSave:(id)sender{
    Note *note=[self.inputView getValue];
    [self.navigationController popViewControllerAnimated:YES];
    ViewController *viewController=(ViewController*)[self.navigationController visibleViewController];
    
    [viewController updateData:note];
}

-(void)didReceiveMemoryWarning{
    
}
@end
