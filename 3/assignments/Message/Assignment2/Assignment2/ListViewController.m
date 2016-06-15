
#import "ListViewController.h"
#import "MHTabBarController.h"
#import "Message.h"
#import "MessageCell.h"
#import "STBubbleTableViewCellDemoViewController.h"

@implementation ListViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	NSLog(@"%@ viewDidLoad", self.title);
    self.messageDatas=[NSMutableArray arrayWithCapacity:6];
    
    [self reloadData];
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    
    _searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController.searchBar sizeToFit];
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}

-(void)reloadData{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"M/d/yyyy h:m"];
    
    NSDate *date1=[NSDate date];
    UIImage *image1=[[UIImage alloc]initWithContentsOfFile:@"portrait"];
    Message *message1=[[Message alloc]initWithMessageNumber:@"15778945625" messageDate:[formatter stringFromDate:date1] messageContent:@"This is message one." messageImage:image1];
    [self.messageDatas addObject:message1];
    
    NSDate *date2=[NSDate date];
    UIImage *image2=[[UIImage alloc]initWithContentsOfFile:@"portrait"];
    Message *message2=[[Message alloc]initWithMessageNumber:@"7823354123" messageDate:[formatter stringFromDate:date2] messageContent:@"This is message two." messageImage:image2];
    [self.messageDatas addObject:message2];
    
    NSDate *date3=[NSDate date];
    UIImage *image3=[[UIImage alloc]initWithContentsOfFile:@"portrait"];
    Message *message3=[[Message alloc]initWithMessageNumber:@"2343463463" messageDate:[formatter stringFromDate:date3] messageContent:@"This is message three." messageImage:image3];
    [self.messageDatas addObject:message3];
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
    if(self.searchController.active){
        self.searchController.active=NO;
        [self.searchController.searchBar removeFromSuperview];
    }
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

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self.searchList removeAllObjects];
    NSString *pattern=@"[0-9]*";
    pattern=[pattern stringByAppendingFormat:@"%@[0-9]*",self.searchController.searchBar.text];
    NSString *pattern1=@"\\w*";
    pattern1=[pattern1 stringByAppendingFormat:@"%@\\w*",self.searchController.searchBar.text];
    NSRegularExpression *reg=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSRegularExpression *reg1=[NSRegularExpression regularExpressionWithPattern:pattern1 options:0 error:nil];
    NSMutableArray *list=[[NSMutableArray alloc]initWithCapacity:6];
    for (int i=0; i<[self.messageDatas count]; i++) {
        Message *message=[self.messageDatas objectAtIndex:i];
        NSArray* match = [reg matchesInString:message.number options:NSMatchingAnchored range:NSMakeRange(0, [message.number length])];
        if (match.count>0) {
            [list addObject:message];
            continue;
        }
        match = [reg1 matchesInString:message.content options:NSMatchingAnchored range:NSMakeRange(0, [message.content length])];
        if(match.count>0){
            [list addObject:message];
            continue;
        }
    }
//    NSMutableArray *List=[self.searchList mutableCopy];
    self.searchList=[list mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"message count: %d",[_messageDatas count]);
    if (self.searchController.active) {
        return [self.searchList count];
    }else
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
                break;
            }
        }
    }
    if (self.searchController.active) {
        [cell setupCell:self.searchList[indexPath.row]];
    }else
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

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
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
    NSLog(@"%@, parent is %@", self.title, self.parentViewController);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    ListViewController *listViewController1 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
//    ListViewController *listViewController2 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
//    
//    STBubbleTableViewCellDemoViewController *bubbleController=[STBubbleTableViewCellDemoViewController new];
//    [bubbleController loadData:self.messageDatas[indexPath.row]];
//    bubbleController.title=((Message *)self.messageDatas[indexPath.row]).number;
//    
//    
//    listViewController1.title = @"Another Tab 1";
//    listViewController2.title = @"Another Tab 2";
//    
//    MHTabBarController *tabBarController = [[MHTabBarController alloc] init];
////    tabBarController.viewControllers = @[listViewController1,listViewController2];
//    tabBarController.viewControllers=@[bubbleController];
//    tabBarController.title = @"Message";
//    tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
//                                                         initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
//    
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
//    navController.navigationBar.tintColor = [UIColor blackColor];
//    [self presentViewController:navController animated:YES completion:nil];
    
    LGChatController *chatController = [LGChatController new];
    chatController.opponentImage = [UIImage imageNamed:@"portrait"];
    chatController.title = @"Message";
    //    LGChatMessage *helloWorld = [[LGChatMessage alloc] initWithContent:@"Hello World!" sentByString:[LGChatMessage SentByUserString]];
    Message *message=self.messageDatas[indexPath.row];
    LGChatMessage *mess = [[LGChatMessage alloc] initWithContent:message.content sentByString:[LGChatMessage SentByUserString]];
//    LGChatMessage *mess=[[LGChatMessage new] init];
//    mess.content=message.content;
//    mess.sentByString=message.content;
    chatController.messages = @[mess]; // Pass your messages here.
    chatController.delegate = self;
    self.navigationController.navigationBarHidden=NO;
    [[self navigationController] pushViewController:chatController animated:YES];
    [self.navigationController.navigationItem.backBarButtonItem setAction:@selector(done:)];
}

- (IBAction)done:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)chatController:(LGChatController *)chatController didAddNewMessage:(LGChatMessage *)message
{
    NSLog(@"Did Add Message: %@", message.content);
}

- (BOOL)shouldChatController:(LGChatController *)chatController addMessage:(LGChatMessage *)message
{
    /*
     This is implemented just for demonstration so the sent by is randomized.  This way, the full functionality can be demonstrated.
     */
    message.sentByString = arc4random_uniform(2) == 0 ? [LGChatMessage SentByOpponentString] : [LGChatMessage SentByUserString];
    return YES;
}

@end
