//
//  WelcomeViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController {
    
    IBOutlet UILabel *welcome_vinacredit;
    IBOutlet UILabel *welcome_text;
    IBOutlet UIButton *addSignIn;

}
@property (strong, nonatomic) IBOutlet UILabel *welcome_vinacredit;
@property (strong, nonatomic) IBOutlet UILabel *welcome_text;
@property (strong, nonatomic) IBOutlet UIButton *addSignIn;

- (IBAction)gotoSignIn:(id)sender;
- (IBAction)selectVietnam:(id)sender;
- (IBAction)selectEnglish:(id)sender;


@end
