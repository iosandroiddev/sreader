//
//  InfoAccountViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/31/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//
#define SCROLLVIEW_CONTENT_HEIGHT 416
#define SCROLLVIEW_CONTENT_WIDTH  320

#import "Library.h"
#import "Macros.h"
#import "Account.h"
#import "ConnectDatabase.h"
#import "InfoAccountViewController.h"

@implementation InfoAccountViewController

@synthesize btnImage;
@synthesize firstName;
@synthesize lastName;
@synthesize companyName;
@synthesize emailName;
@synthesize password;
@synthesize confirmPass;
@synthesize oldpass;
@synthesize scrollView;
@synthesize address;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    scrollView.contentSize = CGSizeMake(SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);

}

-(void) keyboardDidShow: (NSNotification *)notif {
	NSLog(@"Keyboard is visible");
	// If keyboard is visible, return
	if (keyboardVisible) {
		NSLog(@"Keyboard is already visible. Ignore notification.");
		return;
	}
	
	// Get the size of the keyboard.
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	// Save the current location so we can restore
	// when keyboard is dismissed
	offset = scrollView.contentOffset;
	
	// Resize the scroll view to make room for the keyboard
	CGRect viewFrame = scrollView.frame;
	viewFrame.size.height -= keyboardSize.height;
	scrollView.frame = viewFrame;
	
	CGRect textFieldRect = [activeField frame];
	textFieldRect.origin.y += 10;
	[scrollView scrollRectToVisible:textFieldRect animated:YES];
	
	NSLog(@"ao fim");
	// Keyboard is now visible
	keyboardVisible = YES;
}

-(void) keyboardDidHide: (NSNotification *)notif {
	// Is the keyboard already shown
	if (!keyboardVisible) {
		NSLog(@"Keyboard is already hidden. Ignore notification.");
		return;
	}
	
	// Reset the frame scroll view to its original value
	scrollView.frame = CGRectMake(0, 44, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
	
	// Reset the scrollview to previous location
	scrollView.contentOffset = offset;
	NSLog(@"Keyboard is already hidden");
	// Keyboard is no longer visible
	keyboardVisible = NO;
	
}

-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
	activeField = textField;    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
    NSLog(@"firstname:%@",firstName.text);
    NSLog(@"lastName:%@",lastName.text);
    NSLog(@"companyName:%@",companyName.text);
    NSLog(@"address:%@",address.text);
    NSLog(@"emailName:%@",emailName.text);
    NSLog(@"oldpass:%d",oldpass.text.length);
    NSLog(@"password:%@",password.text);
    NSLog(@"confirmPass:%@",confirmPass.text);
    Library *lib = [[Library alloc] init];
    if( firstName.text.length > 0 && lastName.text.length > 0 && companyName.text.length > 0 && address.text.length > 0 && emailName.text.length > 0 && oldpass.text.length > 0 &&  password.text.length > 0 && confirmPass.text.length > 0 && [lib isCheckPass:password.text currentPass:confirmPass.text])
    {
        [barButtonSale setEnabled:YES];
    } else {
        [barButtonSale setEnabled:NO];
    }
	return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"asdasd:%@",firstName.text);
    keyboardVisible = NO;
    [barButtonSale setEnabled:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    barButtonWelcome = nil;
    barButtonSale = nil;
    lastName = nil;
    firstName = nil;
    companyName = nil;
    emailName = nil;
    password = nil;
    confirmPass = nil;
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setCompanyName:nil];
    [self setEmailName:nil];
    [self setPassword:nil];
    [self setConfirmPass:nil];
    scrollView = nil;
    [self setScrollView:nil];
    oldpass = nil;
    [self setOldpass:nil];
    btnImage = nil;
    [self setBtnImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gotoSale:(id)sender {
    Account *account = [[Account alloc] initWithEmail:emailName.text firstName:firstName.text lastName:lastName.text companyName:companyName.text pass:password.text imageAcc:btnImage.imageView.image address:address.text];
    [[ConnectDatabase database] insertAcc:account];
    
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:SALE pushView:TRUE navigationController:self.navigationController];
}

- (IBAction)btnIma:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Action Sheet"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo",@"Choose Photo", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        
        if(buttonIndex == 0)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:imagePicker animated:YES];
        }
        if(buttonIndex ==1)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO)
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentModalViewController:imagePicker animated:YES];
        }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [btnImage setImage:[info objectForKey:UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
//    btnImage.imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissModalViewControllerAnimated:YES];
    NSLog(@"test image picker");
    
}

@end
