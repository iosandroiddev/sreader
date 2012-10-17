//
//  AccountViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleHistoryViewController;
@class TaxViewController;
@class SupportViewController;
@class SaleViewController;
@class SignOutViewController;

@interface AccountViewController : UITableViewController < UINavigationBarDelegate, UINavigationControllerDelegate, UITableViewDataSource,UITableViewDelegate, UIActionSheetDelegate> {
    
    
    IBOutlet UIImageView *imageUser;
    IBOutlet UILabel *username;
    NSMutableArray *accountList;
    IBOutlet UILabel *email;
    
    UIImage *image;
    NSString *title;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *imageUser;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *email;

@property (nonatomic,strong) SaleViewController *saleView;
@property (nonatomic,strong) SaleHistoryViewController *saleHistory;
@property (nonatomic,strong) TaxViewController *tax;
@property (nonatomic,strong) SupportViewController *support;
@property (nonatomic,strong) SignOutViewController *signOut;
@property (strong) UIImage *image;
@property (strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *accountList;

- (IBAction) gotoSignOut:(id)sender;
-(IBAction) gotoSaleView:(id)sender;
-(id)initWithTitle:(NSString *)title image:(UIImage *)image;



@end
