//
//  SignInViewController.m
//  vinacredit
//
//  Created by Vinacredit on 9/11/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "SignInViewController.h"
#import "WelcomeViewController.h"
#import "SaleViewController.h"
#import "WrongPassViewController.h"
#import "InfoAccountViewController.h"
#import "Macros.h"
#import "Library.h"
@implementation SignInViewController
@synthesize btnForgot;
@synthesize btnCancel;
@synthesize btnSale;
@synthesize emailAddress;
@synthesize password;
@synthesize lblLoginStatus;

    // add flag, if true skip testSignIn
InfoAccountViewController *info;
SaleViewController *sale;
bool flagFirstLogin = true;

- (void)translate{
    self.title = SIGNIN_LBL;
    emailAddress.placeholder = SIGNIN_EMAIL_TXT;
    password.placeholder = SIGNIN_PASS_TXT;
    [btnSale setTitle:SIGNIN_BTN forState:UIControlStateNormal];
    [btnCancel setTitle:SIGNIN_CANCEL_BTN forState:UIControlStateNormal];
    [btnForgot setTitle:SIGNIN_FORGOT_BTN forState:UIControlStateNormal];
    
}
- (void)viewDidLoad
{
    
    [emailAddress becomeFirstResponder];
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view from its nib.
    [self translate];
    if (NO_TEST_SIGNIN)return;
    users = [[NSMutableArray alloc] init];
    NSURL *xmlURL = [NSURL URLWithString:@"https://sites.google.com/site/vinacreditdemo/home/user.xml"];
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [xmlParser setDelegate:self];
    [xmlParser parse];    // Do any additional setup after loading the view from its nib.    
}

- (void)viewDidUnload
{
    emailAddress = nil;
    password = nil;
    [self setEmailAddress:nil];
    [self setPassword:nil];
    lblLoginStatus = nil;
    [self setLblLoginStatus:nil];
    btnSale = nil;
    [self setBtnSale:nil];
    btnCancel = nil;
    btnForgot = nil;
    [self setBtnCancel:nil];
    [self setBtnForgot:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gotoWelcome:(id)sender {
//    Library *lib = [[Library alloc]init];
//    [lib gotoInterFace:WELCOME pushView:FALSE navigationController:self.navigationController];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    Library *lib = [[Library alloc]init];
    
    if(flagFirstLogin)
        [lib writeFile:@"firstsignin" contentFile:@"TRUE"];
    
        
    sleep(TIME_LOADING);
    
    //BOOL blExistFile = [lib testExitsFile:@"firstsignin"];
    NSString *str_interface = nil;    
    if (flagFirstLogin){
        str_interface = @"InfoAccountViewController";
        if(!BUILD_IPHONE_OR_IPAD)// build ipad
            str_interface = [str_interface stringByAppendingString:@"Ipad"];
        info = [[InfoAccountViewController alloc] initWithNibName:str_interface bundle:[NSBundle mainBundle]];
    }
        
    else{
        str_interface = @"SaleViewController";
        if(!BUILD_IPHONE_OR_IPAD)// build ipad
            str_interface = [str_interface stringByAppendingString:@"Ipad"];
        sale = [[SaleViewController alloc] initWithNibName:str_interface bundle:[NSBundle mainBundle]];
    }
        
    
    if (NO_TEST_SIGNIN){
        if(flagFirstLogin)
            if(SKIP_INFORACCOUNT){
                str_interface = @"SaleViewController";
                if(!BUILD_IPHONE_OR_IPAD)// build ipad
                    str_interface = [str_interface stringByAppendingString:@"Ipad"];
                sale = [[SaleViewController alloc] initWithNibName:str_interface bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:sale animated:YES];
            }
            else    
                [self.navigationController pushViewController:info animated:YES];
        else
            [self.navigationController pushViewController:sale animated:YES];
        return;
    }
    // Test Login
    [self testLogin:flagFirstLogin];
    // end test login

    NSString *blfirst = [lib readFile:@"firstsignin"];
    if([blfirst isEqualToString:@"TRUE"]){
        [lib deleteFile:@"firstsignin"];
        flagFirstLogin = FALSE;
    }


}
- (void)testLogin:(BOOL)flagFirstSignIn{
    for (NSMutableDictionary *val in users) {
        NSString *mutableEmail = [val objectForKey:@"Username"];
        NSString *psswrd = [val objectForKey:@"Password"];
        
            // clear \n \t ...
        mutableEmail=[mutableEmail stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        mutableEmail=[mutableEmail stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        mutableEmail=[mutableEmail stringByReplacingOccurrencesOfString:@" " withString:@""];
        psswrd=[psswrd stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        psswrd=[psswrd stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        psswrd=[psswrd stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([mutableEmail isEqualToString:[emailAddress text]]&&[psswrd isEqualToString:[password text]]){
            [lblLoginStatus setText:@"Login Successful!!"];
            if(DEBUG_SCR)
                NSLog(@"flag %c",flagFirstSignIn);
            if(flagFirstSignIn)
                [self.navigationController pushViewController:info animated:YES];
            else
                [self.navigationController pushViewController:sale animated:YES];
            
            return;
        }
    }
    [lblLoginStatus setText:@"login failed !"];
    return;

}
- (IBAction)gotoSale:(id)sender {
    EMAIL_LOGIN_VALUE = emailAddress.text;
    PASS_LOGIN_VALUE  = password.text;
    
    [emailAddress resignFirstResponder];
    [password resignFirstResponder];

    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.dimBackground = YES;
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
	
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
        
    
    
}

- (IBAction)gotoWrong:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:FORGET_PASS pushView:TRUE navigationController:self.navigationController];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
        //[textField resignFirstResponder];
	return YES;
}
- (IBAction)backgroundClick:(id)sender{
        //[emailAddress resignFirstResponder];
        //[password resignFirstResponder];
}

    // XML Login //
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if(NO_TEST_SIGNIN)return;
    currentElenment = [elementName copy];
    if ([elementName isEqualToString:@"User"]) {
        item = [[NSMutableDictionary alloc] init];
        currentUser =[[NSMutableString alloc] init];
        currentPassword =[[NSMutableString alloc] init];
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if(NO_TEST_SIGNIN)return;
    if ([elementName isEqualToString:@"User"]) {
        [item setObject:currentUser forKey:@"Username"];
        [item setObject:currentPassword forKey:@"Password"];
        [users addObject:[item copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(NO_TEST_SIGNIN)return;
    if ([currentElenment isEqualToString:@"Username"]) {
        [currentUser appendString:string];
    }
    if ([currentElenment isEqualToString:@"Password"]) {
        [currentPassword appendString:string];
    }
}
    // end xml 
@end
