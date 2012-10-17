//
//  WrongPassViewController.h
//  vinacredit
//
//  Created by Vinacredit on 9/11/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface WrongPassViewController : UIViewController <MBProgressHUDDelegate>{
    
    IBOutlet UITextField *emailAddress;
    MBProgressHUD *HUD;
    
    IBOutlet UIButton *btnSend;
    IBOutlet UILabel *lblResultEmail;
}
@property (strong, nonatomic) IBOutlet UITextField *emailAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UILabel *lblResultEmail;

- (IBAction)gotoSignIn:(id)sender;
- (IBAction)sending:(id)sender;

@end
