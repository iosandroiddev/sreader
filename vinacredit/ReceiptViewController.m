//
//  ReceiptViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/31/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "ReceiptViewController.h"
#import "Library.h"
#import "Macros.h"

@implementation ReceiptViewController
@synthesize emailUser;
@synthesize lblTestEmail;


- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [emailUser becomeFirstResponder];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    
    emailUser = nil;
    buttonSkip = nil;
    buttonSend = nil;
    [self setEmailUser:nil];
    lbltestEmail = nil;
    [self setLblTestEmail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (IBAction)buttonSkip:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:DONE pushView:TRUE navigationController:self.navigationController];
}

- (IBAction)buttonSend:(id)sender {
    Library *lib = [[Library alloc]init];
    BOOL tmp = [lib testEmail:emailUser.text];
    if(tmp){        
        lbltestEmail.text = @"You check email.";
        lbltestEmail.textColor = [UIColor blueColor];
    }
    else{
        lbltestEmail.text = @"wrong email !";
        lbltestEmail.textColor = [UIColor redColor];
        return;
    }
    [self sendMail:emailUser.text];
        //[lib gotoInterFace:DONE pushView:TRUE navigationController:self.navigationController];
}
    //send mail
- (BOOL)sendMail:(NSString *)email{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        NSString *strSubject = @"Receipt : ";        
        strSubject = [strSubject stringByAppendingString:SALE_SUM_VALUE];
        strSubject = [strSubject stringByAppendingString:@"VND"];
        [mailer setSubject:strSubject];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:email, nil];
        [mailer setToRecipients:toRecipients];
        
            //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        UIImage *myImage = IMG_SIGNATURE;
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
            //NSString *emailBody = emailUser.text;
        NSString *emailBody = @"Thank you very much.";
        [mailer setMessageBody:emailBody isHTML:NO];
        
            // only for iPad
            // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
        return TRUE;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                    message:@"Your device doesn't support the composer sheet"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    return FALSE;
}

@end
