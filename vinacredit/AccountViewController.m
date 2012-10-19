//
//  AccountViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "AccountViewController.h"

#import "SaleHistoryViewController.h"
#import "TaxViewController.h"
#import "SupportViewController.h"
#import "WelcomeViewController.h"
#import "SaleViewController.h"
#import "Macros.h"
#import "Account.h"
#import "ConnectDatabase.h"
#import "Library.h"

@implementation AccountViewController

@synthesize imageUser;
@synthesize username;
@synthesize email;
@synthesize saleView;
@synthesize saleHistory;
@synthesize tax;
@synthesize support;
@synthesize image ;
@synthesize title ;
@synthesize signOut;
@synthesize accountList;

bool bl_testEmail = FALSE;
-(id)initWithTitle:(NSString *)t image:(UIImage *)i{
    if((self = [super init])){
        self.title = t;
        self.image = i;        
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    NSString *valueEmail = EMAIL_LOGIN_VALUE;
    if(![valueEmail isEqualToString:@""])
        bl_testEmail = TRUE;
    Account *acc = [[Account alloc] init];
    acc = [[ConnectDatabase database] selectAcc:valueEmail];
    username.text = [NSString stringWithFormat:@"%@ %@",acc.lastName,acc.firstName];
    if(acc.imageAcc != NULL)
        imageUser.image = acc.imageAcc;
    email.text = acc.email;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    AccountViewController *list1 = [[AccountViewController alloc] initWithTitle:@"Sales History" image:[UIImage imageNamed:@"Sales History.png"]];
    AccountViewController *list2 = [[AccountViewController alloc] initWithTitle:@"Tax" image:[UIImage imageNamed:@"Tax.png"]];
    AccountViewController *list3 = [[AccountViewController alloc] initWithTitle:@"Support" image:[UIImage imageNamed:@"Help Support.png"]];
    accountList  = [NSMutableArray arrayWithObjects:list1, list2, list3, nil];
    
    self.navigationItem.title = @"Account";
    
    //create a right button
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign out" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoSignOut:)];
	self.navigationItem.rightBarButtonItem = addButtonItem;
    
    //create an add left button
    UIBarButtonItem *btnbackBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(gotoSaleView:)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = btnbackBar;
	
	self.navigationController.delegate = self;
     
}

//
// numberOfSectionsInTableView:
//
// Return the number of sections for the table.
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

//
// tableView:numberOfRowsInSection:
//
// Returns the number of rows in a given section.
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return accountList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];    

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
	// Add disclosure triangle to cell
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    AccountViewController *list = [accountList objectAtIndex:indexPath.row];
	// Get the event at the row selected and display it's title
    [cell.imageView setImage:list.image];
    CGSize imageSize = CGSizeMake(31,31);
    UIGraphicsBeginImageContext(imageSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    [list.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.textLabel.text = list.title;
    if (list.title == @"Tax") {
        //variable subtitle of Tax
        NSString *subtitleTax;
        if(TAX_STATUS_VALUE){
            subtitleTax = TAX_RATE_VALUE;
        }
        else
            subtitleTax = @"OFF";
        cell.detailTextLabel.text = subtitleTax;
    }
	return cell;
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	switch (indexPath.row) {
        case 0:
            if(bl_testEmail){
                if(BUILD_IPHONE_OR_IPAD)
                    self.saleHistory = [[SaleHistoryViewController alloc] initWithNibName:nil bundle:nil];
                else
                    self.saleHistory = [[SaleHistoryViewController alloc] initWithNibName:IPAD_HISTORY_XIB bundle:nil];
                [self.navigationController pushViewController:saleHistory animated:YES];
            }
            else{
                UIAlertView *alert;
                alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You aren't login" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
                [alert show];
            }
            
            break;
        case 1:
            if(BUILD_IPHONE_OR_IPAD)
                self.tax = [[TaxViewController alloc] initWithNibName:nil bundle:nil];
            else
                self.tax = [[TaxViewController alloc] initWithNibName:IPAD_TAX_XIB bundle:nil];
            [self.navigationController pushViewController:tax animated:YES];
            break;
        default:
            if(BUILD_IPHONE_OR_IPAD)
                self.support = [[SupportViewController alloc] initWithNibName:nil bundle:nil];
            else
                self.support = [[SupportViewController alloc] initWithNibName:IPAD_SUPPORT_XIB bundle:nil];
            [self.navigationController pushViewController:support animated:YES];
            break;
    }
}

-(void) gotoSaleView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)gotoSignOut:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Sign Out"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Sign Out", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            Library *lib = [[Library alloc]init];
            [lib gotoInterFace:WELCOME pushView:TRUE navigationController:self.navigationController];
            break;
        }
    }
}
- (void)viewDidUnload{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    imageUser = nil;
    username = nil;
    email = nil;
    [self setImageUser:nil];
    [self setUsername:nil];
    [self setEmail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
