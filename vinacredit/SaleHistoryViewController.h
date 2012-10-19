//
//  SaleHistoryViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailSaleViewController.h"
@interface SaleHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *_itemInfos;
    DetailSaleViewController *_details;
    IBOutlet UITableView *mainTableView;
    IBOutlet UIImageView *imageU;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageU;
@property (nonatomic, strong) NSArray *itemInfos;
@property (nonatomic, strong) DetailSaleViewController *details;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

//-(IBAction) gotoAccountView:(id)sender;

@end
