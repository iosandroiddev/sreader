//
//  DoneViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/31/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "DoneViewController.h"
#import "Macros.h"
#import "Account.h"
#import "ConnectDatabase.h"
#import "Library.h"
#import "SumBill.h"
#import "Bill.h"
#import "SaleViewController.h"
#import "ParseDate.h"
@interface DoneViewController ()

@end

@implementation DoneViewController

@synthesize imageU;
@synthesize priceDone;
@synthesize lblSumPaid;
@synthesize valueEmail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    Library *lib = [[Library alloc]init];
    valueEmail = [lib readFile:@"emaillogin"];
    
    Account *acc = [[Account alloc] init];
    acc = [[ConnectDatabase database] selectAcc:valueEmail];
    
    if(acc.imageAcc != NULL)
        imageU.image = acc.imageAcc;
    
        // get value 
    lblSumPaid.text = [lib readFile:@"sumprice"];
    lblSumPaid.text = [lblSumPaid.text stringByAppendingString:@" VND"];
}

- (void)viewDidUnload
{
    priceDone = nil;
    buttonDone = nil;
    [self setPriceDone:nil];
    lblSumPaid = nil;
    [self setLblSumPaid:nil];
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

- (IBAction)buttonDone:(id)sender {
    ParseDate *d = [[ParseDate alloc] init];
    Bill *bill = [[Bill alloc] init];
    SaleViewController *sale = [[SaleViewController alloc]init];
    bill.timeSale = [d getCurrentTime];
    bill.sumItem = lblSumPaid.text;
    bill.dateSale = [d getCurrentDate];
    bill.emailBill = valueEmail;
    SumBill *sum = [[SumBill alloc] initWithDateSale:[d getCurrentDate] sumBill:lblSumPaid.text bill:bill emailSumBill:valueEmail];
    if(BUILD_DEVICE)
        [[ConnectDatabase database] insertBill:sum currentDate:[d getCurrentDate] email:valueEmail];
    
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:SALE pushView:FALSE navigationController:self.navigationController];
    [sale clear];
}
@end
