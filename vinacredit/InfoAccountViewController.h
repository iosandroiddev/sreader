//
//  InfoAccountViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/31/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoAccountViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    IBOutlet UIBarButtonItem *barButtonWelcome;
    IBOutlet UIBarButtonItem *barButtonSale;
    IBOutlet UIButton *btnImage;    
    IBOutlet UITextField *lastName;
    IBOutlet UITextField *firstName;
    IBOutlet UITextField *companyName;
    IBOutlet UITextField *address;
    IBOutlet UITextField *emailName;
    IBOutlet UITextField *password;
    IBOutlet UITextField *confirmPass;    
    IBOutlet UITextField *oldpass;
    
    IBOutlet UIScrollView *scrollView;
    BOOL keyboardVisible;
	CGPoint offset;
	UITextField *activeField;
    UIImagePickerController *imagePicker;
    IBOutlet UILabel *lblNotifyError;
}

@property (strong, nonatomic) IBOutlet UILabel *lblNotifyError;
@property (strong, nonatomic) IBOutlet UIButton *btnImage;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *companyName;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *emailName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPass;
@property (strong, nonatomic) IBOutlet UITextField *oldpass;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)gotoSale:(id)sender;
- (IBAction)btnIma:(id)sender;

@end
