
#import <Foundation/Foundation.h>
#import "CollectionController.h"
#import "MHTabBarController.h"
#import "Message.h"
#import "MessageCell.h"

@implementation CollectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@ viewDidLoad", self.title);
    self.messageDatas=[NSMutableArray arrayWithCapacity:6];
    
    [self reloadData];
    CGRect rect=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    self.addBtn=[[UIButton alloc]initWithFrame:rect];
    self.addBtn.titleLabel.text=@"Add an expression";
    [self.view addSubview:self.addBtn];
    rect.origin.y=20;
    rect.size.height=[UIScreen mainScreen].bounds.size.height-20;
    self.tableView.frame=rect;
    [self.view addSubview:self.tableView];
}

-(void)reloadData{
    [self.messageDatas addObject:@"I'm in a meeting."];
    [self.messageDatas addObject:@"Getting Ready For a Journey."];
    [self.messageDatas addObject:@"Call you back later."];
    [self.messageDatas addObject:@"Please call me later"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear", self.title);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@ viewDidAppear", self.title);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear", self.title);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"%@ viewDidDisappear", self.title);
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    NSLog(@"%@ willMoveToParentViewController %@", self.title, parent);
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    NSLog(@"%@ didMoveToParentViewController %@", self.title, parent);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    NSLog(@"%@ willRotateToInterfaceOrientation", self.title);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"message count: %d",[_messageDatas count]);
    return [self.messageDatas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //	static NSString *CellIdentifier = @"Cell";
    //
    //	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //	if (cell == nil)
    //		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //
    //	cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //	cell.textLabel.text = [NSString stringWithFormat:@"%@ - Row %i", self.title, indexPath.row];
    
    static NSString *messageCell=@"messageCell";
    MessageCell *cell=(MessageCell *)[tableView dequeueReusableCellWithIdentifier:messageCell];
    if(cell==nil){
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"TableCell" owner:self options:nil];
        for (id oneObject in nib){
            if ([oneObject isKindOfClass:[MessageCell class]]) {
                cell=[(MessageCell *)oneObject initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:messageCell];
                cell.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 92.0f);
                
            }
        }
    }
    [cell setupCell:self.messageDatas[[indexPath row]]];
    
    //    static NSString *TableSampleIdentifier = @"TableCellIdentifier";
    //
    //    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:
    //                             TableSampleIdentifier];
    //    if (cell == nil) {
    //        cell = [[MessageCell alloc]
    //                initWithStyle:UITableViewCellStyleDefault
    //                reuseIdentifier:TableSampleIdentifier];
    //    }
    //    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //
    //    NSUInteger row = [indexPath row];
    //    [cell setupCell:[self.messageDatas objectAtIndex:row]];
    //    cell.textLabel.text = [self.messageDatas objectAtIndex:row];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.messageDatas removeObjectAtIndex:indexPath.row];
        //        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView reloadData];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
