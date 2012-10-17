//
//  SignInViewController.h
//  vinacredit
//
//  Created by Vinacredit on 9/11/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface SignInViewController : UIViewController <MBProgressHUDDelegate, NSXMLParserDelegate>{
    IBOutlet UITextField *emailAddress;
    IBOutlet UITextField *password;
    IBOutlet UIButton *btnSale;
    
    NSXMLParser *xmlParser;
    NSMutableArray *users;
    NSMutableDictionary *item;
    NSMutableString *currentUser;
    NSMutableString *currentPassword;
    NSString *currentElenment;
    MBProgressHUD *HUD;
    IBOutlet UILabel *lblLoginStatus;
}
@property (strong, nonatomic) IBOutlet UIButton *btnSale;
@property (strong, nonatomic) IBOutlet UITextField *emailAddress;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UILabel *lblLoginStatus;

- (IBAction)gotoWelcome:(id)sender;
- (IBAction)gotoSale:(id)sender;
- (IBAction)gotoWrong:(id)sender;

- (IBAction)backgroundClick:(id)sender;

@end
