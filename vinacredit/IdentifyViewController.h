//
//  IdentifyViewController.h
//  vinacredit
//
//  Created by Vinacredit on 1/10/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface IdentifyViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>{
    

    IBOutlet UILabel *lblPictureIdentify;
    IBOutlet UIImageView *img;
    UIImagePickerController *imagePicker;
}


- (IBAction)takePhoto:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblPictureIdentify;
@property (strong, atomic) ALAssetsLibrary* library;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@end
