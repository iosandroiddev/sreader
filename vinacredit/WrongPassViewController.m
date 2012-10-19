//
//  WrongPassViewController.m
//  vinacredit
//
//  Created by Vinacredit on 9/11/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "WrongPassViewController.h"
#import "Library.h"
#import "Macros.h"
@implementation WrongPassViewController
@synthesize emailAddress;
@synthesize btnSend;
@synthesize lblResultEmail;

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
    [self focusFieldTest];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    emailAddress = nil;
    [self setEmailAddress:nil];
    btnSend = nil;
    [self setBtnSend:nil];
    lblResultEmail = nil;
    [self setLblResultEmail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)focusFieldTest{
    [emailAddress becomeFirstResponder];    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gotoSignIn:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:SIGNIN pushView:FALSE navigationController:self.navigationController];
}

- (IBAction)sending:(id)sender {
    Library *lib = [[Library alloc]init];
    BOOL tmp = [lib testEmail:emailAddress.text];
    if(tmp){
        btnSend.enabled = TRUE;
        lblResultEmail.text = @"You check email.";
        lblResultEmail.textColor = [UIColor blueColor];
    }
    else{
        lblResultEmail.text = @"wrong email !";
        lblResultEmail.textColor = [UIColor redColor];
        return;
    }
    
    
    [self textFieldShouldReturn:emailAddress];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.dimBackground = YES;
	
        // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
	
        // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(myTaskWrong) onTarget:self withObject:nil animated:YES];
}
- (void)myTaskWrong {
        // Do something usefull in here instead of sleeping ...
  
    sleep(TIME_LOADING);
        //[self focusFieldTest];
        //WelcomeViewController *welcome = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:[NSBundle mainBundle]];
        //[self.navigationController pushViewController:welcome animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}
@end
