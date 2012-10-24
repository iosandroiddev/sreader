//
//  SendingViewController.m
//  vinacredit
//
//  Created by Vinacredit on 1/10/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "SendingViewController.h"
#import "Library.h"
#import "Macros.h"
@interface SendingViewController ()

@end

@implementation SendingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    Library *lib = [[Library alloc]init];
    [lib translate:LANGUAGE_BL];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = SEND_LBL;
    //create a right button
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Email" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoReceipt:)];
	self.navigationItem.rightBarButtonItem = addButtonItem;
    
    //create an add left button
    UIBarButtonItem *btnbackBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(gotoSignature:)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = btnbackBar;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gotoSignature:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:SIGNATURE pushView:FALSE navigationController:self.navigationController];
}

- (IBAction)gotoReceipt:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:RECEIPT pushView:TRUE navigationController:self.navigationController];
}
@end
