//
//  DetailSaleViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailSaleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *_detail;
    NSString *date;
    NSString *email;
    IBOutlet UIImageView *image;
    IBOutlet UILabel *totalLabel;
    IBOutlet UITableView *mainTableView;
    IBOutlet UILabel *lblTotal;
    NSString *total;
}

@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSArray *detail;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *email;
//-(IBAction) gotoHistoryView:(id)sender;
@end
