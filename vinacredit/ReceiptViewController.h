//
//  ReceiptViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/31/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface ReceiptViewController : UIViewController <MFMailComposeViewControllerDelegate>{
    
    IBOutlet UITextField *emailUser;
    IBOutlet UIButton *buttonSkip;
    IBOutlet UIButton *buttonSend;
    IBOutlet UILabel *lbltestEmail;
}
@property (strong, nonatomic) IBOutlet UITextField *emailUser;
@property (strong, nonatomic) IBOutlet UILabel *lblTestEmail;

- (IBAction)buttonSkip:(id)sender;
- (IBAction)buttonSend:(id)sender;

@end
