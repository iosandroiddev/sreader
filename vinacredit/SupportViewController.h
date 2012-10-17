//
//  SupportViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupportViewController : UIViewController {
    
    IBOutlet UIButton *gotoVinacredit;
    IBOutlet UIButton *gotoNumber;
    IBOutlet UIButton *gotoInstruc;
}
@property (strong, nonatomic) IBOutlet UIButton *gotoVinacredit;
@property (strong, nonatomic) IBOutlet UIButton *gotoNumber;
@property (strong, nonatomic) IBOutlet UIButton *gotoInstruc;

- (IBAction)gotoVinacredit:(id)sender;
- (IBAction)gotoNumber:(id)sender;
- (IBAction)gotoInstruc:(id)sender;

- (IBAction)gotoAccount:(id)sender;


@end
