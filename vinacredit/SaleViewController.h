//
//  SaleViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"
#import "AddCell.h"
#import "ItemCell.h"
#import "AccountViewController.h"
#import "ChargeViewController.h"
#import "Library.h"

#import "AudioUnit/AudioUnit.h"
#import "AudioUnit/AUComponent.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SaleViewController : UIViewController <UINavigationControllerDelegate, UINavigationBarDelegate, UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,AddCellDelegate,Customized1CellDelegate>{
    
    IBOutlet UIView *firstView;
    IBOutlet UIView *secondView;
    IBOutlet UIImageView *imageItem;
    IBOutlet UILabel *labelSum;
    UIImagePickerController *imagePicker;
    IBOutlet UIButton *takeIdentifed;
    NSString *value;
    NSString *text;
    UIImage *ima;
    int v;
    ItemCell *itemcell;
    AddCell *addcell;
    
    Library *lib;
    NSString *valueEmail;
    
    NSString *m_strLog;
    IBOutlet UIImageView *imgSreader;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgSreader;
@property (strong, nonatomic) IBOutlet UILabel *labelSum;
@property (strong, nonatomic) IBOutlet UIButton *takeIdentifed;
@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *rowDataArray;
@property (strong, nonatomic) Library *lib;


- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)gotoAccount:(id)sender;
- (IBAction)gotoCharge:(id)sender;
- (IBAction)gotoIdentify:(id)sender;
- (IBAction)clear;

- (void)resetValueVariable;

- (BOOL)hasHeadset;
- (BOOL)SReader_Detect;
@end
