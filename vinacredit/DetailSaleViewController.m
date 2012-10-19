//
//  DetailSaleViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "DetailSaleViewController.h"
#import "Bill.h"
#import "ConnectDatabase.h"
#import "SaleHistoryViewController.h"
#import "Cell.h"
#import "Library.h"
#import "Account.h"
#import "Macros.h"
#import "Library.h"
@implementation DetailSaleViewController

@synthesize image = _image;
@synthesize totalLabel = _totalLabel;
@synthesize mainTableView = _mainTableView;
@synthesize detail = _detail;
@synthesize total;
@synthesize date;
@synthesize email;

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    self.detail = [[ConnectDatabase database] bills:date email:email];

    [self.mainTableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    Library *lib = [[Library alloc]init];
    NSString *valueEmail = EMAIL_LOGIN_VALUE;
    Account *acc = [[Account alloc] init];
    acc = [[ConnectDatabase database] selectAcc:valueEmail];
    if(acc.imageAcc != NULL)
        _image.image = acc.imageAcc;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [_totalLabel setText:[lib addDotNumber:total]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    image = nil;
    label = nil;
    totalLabel = nil;
    [self setImage:nil];
    [self setTotalLabel:nil];
    mainTableView = nil;
    [self setMainTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) gotoHistoryView:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:HISTORY pushView:FALSE navigationController:self.navigationController];
}
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_detail count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    Cell *cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
            cell = (Cell*)[[[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil] lastObject];
    }
    
    Library *lib = [[Library alloc] init];
    Bill *info = [_detail objectAtIndex:indexPath.row ];
    cell.bill.text = [NSString stringWithFormat:@"Bill %d",[_detail count] - indexPath.row];
    cell.time.text = info.timeSale;
    cell.sumItem.text = [lib addDotNumber:info.sumItem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
