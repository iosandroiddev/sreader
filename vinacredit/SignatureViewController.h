//
//  SignatureViewController.h
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Resource/FreeformLineDrawer.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
@interface SignatureViewController : UIViewController <UIActionSheetDelegate, MBProgressHUDDelegate>{
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    BOOL isShowingLandscapeView;
    MBProgressHUD *HUD;
@private
    CALayer *freeformLayer;
    UIPanGestureRecognizer *panGestureRecognizer;
    FreeformLineDrawer *freeformLineDrawer;

}
@property (strong, nonatomic) IBOutlet UIImageView *drawImage;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

- (IBAction)save:(id)sender;
- (IBAction)gotoReceipt:(id)sender;
- (IBAction)clear;

- (IBAction)drawSquiggly:(id)sender;

@end
