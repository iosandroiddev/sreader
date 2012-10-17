//
//  DoneViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/31/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoneViewController : UIViewController {
    
    IBOutlet UILabel *priceDone;
    IBOutlet UIButton *buttonDone;
    IBOutlet UIImageView *imageU;
    IBOutlet UILabel *lblSumPaid;
    
    
}
@property (strong, nonatomic) IBOutlet UIImageView *imageU;
@property (strong, nonatomic) IBOutlet UILabel *priceDone;
@property (strong, nonatomic) IBOutlet UILabel *lblSumPaid;

@property (strong, nonatomic) NSString *timeSale;
@property (strong, nonatomic) NSString *sumItem;
@property (strong, nonatomic) NSString *sumBill;
@property (strong, nonatomic) NSString *dateSale;
@property (strong, nonatomic) NSString *emailSumBill;

- (IBAction)buttonDone:(id)sender;

@end
