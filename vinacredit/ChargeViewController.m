//
//  ChargeViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "ChargeViewController.h"
#import "Library.h"
#import "Macros.h"
@implementation ChargeViewController
@synthesize priceItem;
@synthesize buttonReceipt;
@synthesize isNumber;
@synthesize lib;
@synthesize lblSumPrice;
@synthesize lblChangePrice;

NSString *tmpPriceItem;
NSString *tmpSumPrice;
NSString *strChange;

- (void)viewDidLoad
{
    //==========================
    self.title = @"Charge";
    UIBarButtonItem *btnbackBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pushBackButton:)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = btnbackBar;
    //==========================
    lib = [[Library alloc]init];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    lblSumPrice.text = SALE_SUM_VALUE;
    tmpSumPrice = lblSumPrice.text;
    
    lblChangePrice.text = @"-";
    lblChangePrice.text = [lblChangePrice.text stringByAppendingString:lblSumPrice.text];
    lblChangePrice.textColor = [UIColor scrollViewTexturedBackgroundColor];
    
    lblSumPrice.text = [lblSumPrice.text stringByAppendingString:@" VND"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    priceItem = nil;
    buttonReceipt = nil;
    [self setPriceItem:nil];
    [self setButtonReceipt:nil];
    priceItem = nil;
    lblSumPrice = nil;
    [self setLblSumPrice:nil];
    lblChangePrice = nil;
    [self setLblChangePrice:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)pushBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)gotoSale:(id)sender {    
    [lib gotoInterFace:SALE pushView:FALSE navigationController:self.navigationController];
}

- (IBAction)gotoReceipt:(id)sender {
    
    bool bTestEmpty = FALSE;
    bTestEmpty = [priceItem.text isEqualToString:@"0"];
    if(bTestEmpty)
        return;    
    
    [lib gotoInterFace:RECEIPT pushView:TRUE navigationController:self.navigationController];
}
-(IBAction)digitPressed:(UIButton *)sender{
    NSString *digit = [sender currentTitle];
    if(self.isNumber) {
        if(![@"0" isEqualToString:priceItem.text]) {
            tmpPriceItem = [tmpPriceItem stringByAppendingString:digit];
            
        } else {
            if([[sender currentTitle] isEqualToString:@"000"])
                return;
            tmpPriceItem = digit;
        }
    } else {
        if([[sender currentTitle] isEqualToString:@"000"])
            return;
        self.isNumber = YES;
        tmpPriceItem = digit;
    }
    if (tmpPriceItem.length > 10)
        tmpPriceItem = @"9999999000";
    double dbPriceItem = [tmpPriceItem doubleValue];

    tmpSumPrice = [tmpSumPrice stringByReplacingOccurrencesOfString:@"," withString:@""];
    double dbSumItem = [tmpSumPrice doubleValue];
    int dbTemp = dbPriceItem - dbSumItem;
    
    strChange = [NSString stringWithFormat:@"%d",dbTemp];
    
        //lblChangePrice.text = [lib addDotNumber:strChange];
    if(dbTemp > 0){
        lblChangePrice.textColor = [UIColor blueColor];
        lblChangePrice.text = [lib addDotNumber:strChange];        
    }
        
    else{
        lblChangePrice.textColor = [UIColor scrollViewTexturedBackgroundColor];
        lblChangePrice.text = [lib addDotNegative:strChange];
    }
    priceItem.text = [lib addDotNumber:tmpPriceItem];
}
-(IBAction)operationPressed:(UIButton *)sender {
    if(self.isNumber) {
        if (tmpPriceItem.length > 1) {
            tmpPriceItem = [tmpPriceItem substringToIndex:tmpPriceItem.length -1];
        } else if (tmpPriceItem.length == 1) {
            priceItem.text = @"0";
            tmpPriceItem =@"0";                 
        }
    }
    double dbtmpPriceItem = [[tmpPriceItem stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    
    tmpSumPrice = [tmpSumPrice stringByReplacingOccurrencesOfString:@"," withString:@""];
    double dbSumItem = [tmpSumPrice doubleValue];
    int dbTemp = dbtmpPriceItem - dbSumItem;
    
    strChange = [NSString stringWithFormat:@"%d",dbTemp];
    if(dbTemp > 0){
        lblChangePrice.textColor = [UIColor blueColor];
        lblChangePrice.text = [lib addDotNumber:strChange];
    }        
    else{
        lblChangePrice.textColor = [UIColor scrollViewTexturedBackgroundColor];
        lblChangePrice.text = [lib addDotNegative:strChange];
    }
    priceItem.text = [lib addDotNumber:tmpPriceItem];
}

@end
