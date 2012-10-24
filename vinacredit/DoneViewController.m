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
@interface DoneViewController ()

@end

@implementation DoneViewController

@synthesize lblThank;
@synthesize buttonDone;
@synthesize imageU;
@synthesize lblSumPaid;
@synthesize valueEmail;
@synthesize Strprice;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    Library *lib = [[Library alloc]init];
    valueEmail = EMAIL_LOGIN_VALUE;
    lblThank.text = DONE_PAID_LBL;
    [buttonDone setTitle:DONE_BTN forState:UIControlStateNormal];
    Account *acc = [[Account alloc] init];
    acc = [[ConnectDatabase database] selectAcc:valueEmail];
    
    if(acc.imageAcc != NULL)
        imageU.image = acc.imageAcc;
    
        // get value 
    lblSumPaid.text = SALE_SUM_VALUE;    
    Strprice = [lib deleteDotNumber:lblSumPaid.text];
    lblSumPaid.text = [lblSumPaid.text stringByAppendingString:@" VND"];
}

- (void)viewDidUnload
{
    buttonDone = nil;
    lblSumPaid = nil;
    [self setLblSumPaid:nil];
    imageU = nil;
    [self setImageU:nil];
    lblThank = nil;
    [self setLblThank:nil];
    [self setButtonDone:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonDone:(id)sender {
    Library *lib = [[Library alloc]init];
    Bill *bill = [[Bill alloc] init];
    SaleViewController *sale = [[SaleViewController alloc]init];
    bill.timeSale = GET_TIME_PAYMENT;
    bill.sumItem = Strprice;
    bill.dateSale = GET_DATE_PAYMENT;
    bill.emailBill = valueEmail;
    SumBill *sum = [[SumBill alloc] initWithDateSale:GET_DATE_PAYMENT sumBill:Strprice bill:bill emailSumBill:valueEmail];
  
    [[ConnectDatabase database] insertBill:sum currentDate:GET_DATE_PAYMENT email:valueEmail];
    
    [lib gotoInterFace:SALE pushView:FALSE navigationController:self.navigationController];
    [sale clear];
}
@end
