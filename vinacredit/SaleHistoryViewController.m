//
//  SaleHistoryViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "SaleHistoryViewController.h"
#import "ConnectDatabase.h"
#import "AccountViewController.h"
#import "SumBill.h"
#import "Library.h"
#import "Account.h"
#import "ConnectDatabase.h"
#import "Macros.h"
@implementation SaleHistoryViewController
@synthesize details = _details;
@synthesize mainTableView = _mainTableView;
@synthesize itemInfos = _itemInfos;
@synthesize imageU;

- (void)viewDidLoad
{
    [super viewDidLoad];
    Library *lib = [[Library alloc]init];
    [lib translate:LANGUAGE_BL];
    NSString *valueEmail = EMAIL_LOGIN_VALUE;
    Account *acc = [[Account alloc] init];
    acc = [[ConnectDatabase database] selectAcc:valueEmail];
    if(acc.imageAcc != NULL)
        imageU.image = acc.imageAcc;
    self.itemInfos = [[ConnectDatabase database] sumBill:valueEmail];
    self.title = SALEHISTORY_LBL;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    mainTableView = nil;
    [self setMainTableView:nil];
    imageU = nil;
    [self setImageU:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mainTableView reloadData];
}
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_itemInfos count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    // Set up the cell...
    SumBill *info = [_itemInfos objectAtIndex:indexPath.row];
    cell.textLabel.text = info.dateSale;
    UILabel *label;
    if(BUILD_IPHONE_OR_IPAD)
        label = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 4.0f, 95.0f, 35.0f)];
    else
        label = [[UILabel alloc] initWithFrame:CGRectMake(620.0f, 4.0f, 95.0f, 35.0f)];
    label.autoresizesSubviews = YES;
    Library *lib = [[Library alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentRight;
    label.text = [lib addDotNumber:info.sumBill];
    [cell addSubview:label];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (self.details == nil) {
        if(BUILD_IPHONE_OR_IPAD)
            self.details = [[DetailSaleViewController alloc] initWithNibName:@"DetailSaleViewController" bundle:nil];
        else
            self.details = [[DetailSaleViewController alloc] initWithNibName:@"DetailSaleViewControllerIpad" bundle:nil];
    }    
    SumBill *info = [_itemInfos objectAtIndex:indexPath.row ];
    _details.date = info.dateSale;
    _details.email = info.emailSumBill;
    _details.total = info.sumBill;
        [self.navigationController pushViewController:_details animated:YES];
    
}

//-(IBAction) gotoAccountView:(id)sender {
//    Library *lib = [[Library alloc]init];
//    [lib gotoInterFace:ACCOUNT pushView:FALSE navigationController:self.navigationController];    
//}
@end
