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
@synthesize buttonSkip;
@synthesize buttonSend;


- (void)viewDidLoad
{
    Library *lib = [[Library alloc] init];
    GET_DATE_PAYMENT = [lib getCurrentDate];
    GET_TIME_PAYMENT = [lib getCurrentTime];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [emailUser becomeFirstResponder];
    [super viewDidLoad];
    
    emailUser.placeholder = RECEIPT_EMAIL_TXT;
    [buttonSkip setTitle:RECEIPT_SKIP_BTN forState:UIControlStateNormal];
    [buttonSend setTitle:RECEIPT_SEND_BTN forState:UIControlStateNormal];
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
    [self setButtonSkip:nil];
    [self setButtonSend:nil];
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
        lbltestEmail.text = RECEIPT_RESULT_TRUE_LBL;
        lbltestEmail.textColor = [UIColor blueColor];
    }
    else{
        lbltestEmail.text = RECEIPT_RESULT_FALSE_LBL;
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
        
        NSString *strSubject = @"Receipt: ";
        strSubject = [strSubject stringByAppendingString:GET_TIME_PAYMENT];
        strSubject = [strSubject stringByAppendingString:@" "];
        strSubject = [strSubject stringByAppendingString:GET_DATE_PAYMENT];
        strSubject = [strSubject stringByAppendingString:@" "];
        strSubject = [strSubject stringByAppendingString:EMAIL_LOGIN_VALUE];
        [mailer setSubject:strSubject];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:email, nil];
        [mailer setToRecipients:toRecipients];
        
        NSArray *toCcRecipients =[NSArray arrayWithObject:EMAIL_VINACREDIT_STR];
        [mailer setCcRecipients:toCcRecipients];
        
            //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
            //UIImage *myImage = IMG_SIGNATURE;
            //NSData *imageData = UIImagePNGRepresentation(myImage);
            //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
            //NSString *emailBody = emailUser.text;
        NSString *emailBody = @"Hi ";
        emailBody = [emailBody stringByAppendingString:emailUser.text];
        emailBody = [emailBody stringByAppendingString:@",\n\n"];
        emailBody = [emailBody stringByAppendingString:@"Total :"];
        emailBody = [emailBody stringByAppendingString:SALE_SUM_VALUE];
        emailBody = [emailBody stringByAppendingString:@" VND"];
        emailBody = [emailBody stringByAppendingString:@"\n\n"];
        emailBody = [emailBody stringByAppendingString:@"Thank you very much."];
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
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
        NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
        break;
		case MFMailComposeResultSaved:
        NSLog(@"Mail saved: you saved the email message in the Drafts folder");
        break;
		case MFMailComposeResultSent:{
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
            Library *lib = [[Library alloc]init];
            [lib gotoInterFace:DONE pushView:YES navigationController:self.navigationController];
            break;		    
        }
        case MFMailComposeResultFailed:
        NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
        break;
		default:
        NSLog(@"Mail not sent");
        break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

@end
