//
//  STBubbleTableViewCellDemoViewController.m
//  STBubbleTableViewCellDemo
//
//  Created by Cedric Vandendriessche on 24/08/13.
//  Copyright 2013 FreshCreations. All rights reserved.
//

#import "STBubbleTableViewCellDemoViewController.h"
#import "STBubbleTableViewCell.h"

@interface STBubbleTableViewCellDemoViewController () <STBubbleTableViewCellDataSource, STBubbleTableViewCellDelegate>
@property (nonatomic, strong) NSMutableArray *messages;
@end

@implementation STBubbleTableViewCellDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Messages";
	
	self.tableView.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
	
	// Some decoration
//	CGSize screenSize = [[UIScreen mainScreen] applicationFrame].size;
//	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenSize.width, 55.0f)];
//	
//	UIButton *callButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	callButton.frame = CGRectMake(10.0f, 10.0f, (screenSize.width / 2.0f) - 10.0f, 35.0f);
//	callButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
//	[callButton setTitle:@"Call" forState:UIControlStateNormal];
//	
//	UIButton *contactButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	contactButton.frame = CGRectMake((screenSize.width / 2.0f) + 10.0f, 10.0f, (screenSize.width / 2.0f) - 20.0f, 35.0f);
//	contactButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
//	[contactButton setTitle:@"Contact Info" forState:UIControlStateNormal];
//	
//	[headerView addSubview:callButton];
//	[headerView addSubview:contactButton];
//	
//	self.tableView.tableHeaderView = headerView;
}

-(void)loadData:(Message *)message{
    if (self.messages==nil) {
        self.messages=[[NSMutableArray alloc]initWithObjects:message, nil];
    }else{
        [self.messages addObject:message];
    }
}

#pragma mark - UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Bubble Cell";

    STBubbleTableViewCell *cell = (STBubbleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[STBubbleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = self.tableView.backgroundColor;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
		cell.dataSource = self;
		cell.delegate = self;
	}
	
	Message *message = [self.messages objectAtIndex:indexPath.row];
	
	cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
	cell.textLabel.text = message.content;
	cell.imageView.image = [UIImage imageNamed:message.portrait];
    cell.authorType = STBubbleTableViewCellAuthorTypeSelf;
    cell.bubbleColor = STBubbleTableViewCellBubbleColorGreen;
	
    // Put your own logic here to determine the author
//	if(indexPath.row % 2 != 0 || indexPath.row == 4)
//	{
//		cell.authorType = STBubbleTableViewCellAuthorTypeSelf;
//		cell.bubbleColor = STBubbleTableViewCellBubbleColorGreen;
//	}
//	else
//	{
//		cell.authorType = STBubbleTableViewCellAuthorTypeOther;
//		cell.bubbleColor = STBubbleTableViewCellBubbleColorGray;
//	}
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	Message *message = [self.messages objectAtIndex:indexPath.row];
	
	CGSize size;
	
	if([UIImage imageNamed: message.portrait])
    {
        size = [message.content boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - STBubbleImageSize - 8.0f - STBubbleWidthOffset, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}
                                             context:nil].size;
    }
	else
    {
        size = [message.content boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - STBubbleWidthOffset, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}
                                             context:nil].size;
    }
	
	// This makes sure the cell is big enough to hold the avatar
	if(size.height + 15.0f < STBubbleImageSize + 4.0f && [UIImage imageNamed:message.portrait])
    {
		return STBubbleImageSize + 4.0f;
    }
	
	return size.height + 15.0f;
}

#pragma mark - STBubbleTableViewCellDataSource methods

- (CGFloat)minInsetForCell:(STBubbleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
		return 100.0f;
    }
    
	return 50.0f;
}

#pragma mark - STBubbleTableViewCellDelegate methods

- (void)tappedImageOfCell:(STBubbleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	Message *message = [self.messages objectAtIndex:indexPath.row];
	NSLog(@"%@", message.content);
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

@end
