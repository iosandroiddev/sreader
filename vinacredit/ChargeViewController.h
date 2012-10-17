//
//  ChargeViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Library.h"
@interface ChargeViewController : UIViewController {
    
    
    IBOutlet UILabel *priceItem;
    IBOutlet UIButton *buttonReceipt;
    Library *lib;    
    
    IBOutlet UILabel *lblSumPrice;
    IBOutlet UILabel *lblChangePrice;
}
@property (strong, nonatomic) IBOutlet UILabel *priceItem;
@property (strong, nonatomic) IBOutlet UIButton *buttonReceipt;
@property (nonatomic) BOOL isNumber;
@property (strong, nonatomic) Library *lib;
@property (strong, nonatomic) IBOutlet UILabel *lblSumPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblChangePrice;
- (IBAction)gotoSale:(id)sender;
- (IBAction)gotoReceipt:(id)sender;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
@end
