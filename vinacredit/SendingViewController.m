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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
