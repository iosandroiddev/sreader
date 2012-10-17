//
//  IdentifyViewController.h
//  vinacredit
//
//  Created by Vinacredit on 1/10/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdentifyViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>{
    

    IBOutlet UIImageView *img;
    UIImagePickerController *imagePicker;
}


@property (strong, nonatomic) IBOutlet UIImageView *img;
@end
