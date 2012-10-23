//
//  WelcomeViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Library.h"
#import "Macros.h"
@implementation WelcomeViewController
@synthesize welcome_vinacredit;
@synthesize welcome_text;
@synthesize addSignIn;

- (IBAction)gotoSignIn:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:SIGNIN pushView:TRUE navigationController:self.navigationController];
}

- (IBAction)selectVietnam:(id)sender {
    LANGUAGE_BL = NO;
    Library *lib = [[Library alloc]init];
    [lib translate:LANGUAGE_BL];
    [self translate];
}
- (IBAction)selectEnglish:(id)sender {
    LANGUAGE_BL = YES;
    Library *lib = [[Library alloc]init];
    [lib translate:LANGUAGE_BL];
    [self translate];
}
- (void)translate{
    welcome_vinacredit.text = WELCOME_TO_VINACREDIT_LBL;
    welcome_text.text = WELCOME_TEXT_LBL;
    [addSignIn setTitle:WELCOME_SIGNIN_BTN forState:UIControlStateNormal];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{    
    
    welcome_vinacredit = nil;
    [self setWelcome_vinacredit:nil];
    welcome_text = nil;
    [self setWelcome_text:nil];
    addSignIn = nil;
    [self setAddSignIn:nil];
    [super viewDidUnload];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)updateText{
    Library *lib = [[Library alloc]init];
    [lib translate:LANGUAGE_BL];
    welcome_vinacredit.text = WELCOME_TO_VINACREDIT_LBL;
    welcome_text.text = WELCOME_TEXT_LBL;
    [addSignIn setTitle:WELCOME_SIGNIN_BTN forState:UIControlStateNormal];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
