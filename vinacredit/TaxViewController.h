//
//  TaxViewController.h
//  vinacredit
//
//  Created by Vinacredit on 9/12/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaxViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITableView *mainTableView;
    
}
@property (strong, nonatomic) UISwitch *swit;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *image;

    //@property (nonatomic) BOOL isNumber;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)clear;

@end
