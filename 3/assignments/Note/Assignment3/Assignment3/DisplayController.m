
#import <Foundation/Foundation.h>
#import "DisplayController.h"

@implementation DisplayController

-(void)viewDidLoad{
    [super viewDidLoad];
    CGFloat height=40.0f;
    CGRect rectStatus=[[UIApplication sharedApplication]statusBarFrame];
    CGRect rectNav=self.navigationController.navigationBar.frame;
    
    CGRect frame=[[UIScreen mainScreen] bounds];
    CGRect rect=CGRectMake(0, rectStatus.size.height+rectNav.size.height, 150, height);
    
    self.datelabel=[[UILabel alloc]initWithFrame:rect];
    self.datelabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:self.datelabel];
    
    rect.origin.x=frame.size.width-110;
    rect.size.width=50;
    self.likelabel=[[UILabel alloc]initWithFrame:rect];
    self.likelabel.textAlignment=NSTextAlignmentRight;
    self.likelabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:self.likelabel];
    
    rect.origin.x=frame.size.width-60;
    self.switchView=[[UISwitch alloc]initWithFrame:rect];
    [self.view addSubview:self.switchView];
    
    rect.origin.x=0;
    rect.origin.y=rect.origin.y+height;
    rect.size.width=frame.size.width;
    rect.size.height=frame.size.height-rectStatus.size.height-rectNav.size.height-height-10;
    
    self.textView=[[UITextView alloc]initWithFrame:rect];
    self.textView.font = [UIFont fontWithName:@"Arial" size:20];
    
    [self.view addSubview:self.textView];
    self.textView.text=self.note.message;
    self.likelabel.text=@"Star:";
    [self.switchView setOn:self.note.switchLike];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy/M/d HH:mm"];
    self.datelabel.text=[formatter stringFromDate:self.note.date];
    
}

-(void)passMessage:(Note *)nn{
    self.note=nn;
}

-(void)didReceiveMemoryWarning{
    
}
@end

