//
//  SignatureViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "SignatureViewController.h"
#import "CustomPhotoAlbum.h"
#import "Library.h"
#import "Macros.h"


@implementation SignatureViewController

@synthesize btnBar;
@synthesize btnClear;
@synthesize lblText;
@synthesize library;
@synthesize drawImage;
@synthesize priceLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 5.0;
    opacity = 1.0;
    self.view.transform = CGAffineTransformMakeRotation(90*M_PI/180);
        //self.drawImage.transform = CGAffineTransformMakeRotation(180*M_PI/180);
    
    self.library = [[ALAssetsLibrary alloc] init];
    lblText.text = SIGNATURE_TEXT_LBL;
    [btnClear setTitle:SIGNTURE_CLEAR_BTN forState:UIControlStateNormal];
    [btnBar setTitle:SIGNATURE_RIGHT_BTN];
    priceLabel.text = SALE_SUM_VALUE;
    priceLabel.text = [priceLabel.text stringByAppendingString:@" VND"];
    
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self drawSquiggly:nil];
}

- (void)viewDidUnload{
    [self setDrawImage:nil];
    [self setPriceLabel:nil];
    self.library = nil;
    lblText = nil;
    btnClear = nil;
    btnBar = nil;
    [self setBtnBar:nil];
    [self setBtnClear:nil];
    [self setLblText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    
    return NO;
}

- (IBAction)save:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save to Camera Roll", @"Cancel", nil];
    [actionSheet showInView:self.view];    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0) {
     /*
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
        [self.drawImage.image drawInRect:CGRectMake(0, 0, self.drawImage.frame.size.width, self.drawImage.frame.size.height)];
      
        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();      
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
      */
        
        
        
        UIGraphicsBeginImageContext(self.drawImage.frame.size);
        CGContextRef theContext = UIGraphicsGetCurrentContext();
        [self.drawImage.layer renderInContext:theContext];
        
        IMG_SIGNATURE = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //UIImageWriteToSavedPhotosAlbum(IMG_SIGNATURE, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
        [self.library saveImage:IMG_SIGNATURE toAlbum:@"Vinacredit" withCompletionBlock:^(NSError *error) {
            if (error!=nil) {
                NSLog(@"Big error: %@", [error description]);
            }
        }];

     }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    // Was there an error?
    UIAlertView *alert;
    if (error != NULL)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];        
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];        
    }
        //CGAffineTransform affine = CGAffineTransformMakeRotation (M_PI * 90 / 180.0f);
        //[alert setTransform:affine];
    [alert show];

}
    // goto Sending Interface
- (IBAction)gotoReceipt:(id)sender {
    
    UIGraphicsBeginImageContext(self.drawImage.frame.size);
    CGContextRef theContext = UIGraphicsGetCurrentContext();
    [self.drawImage.layer renderInContext:theContext];
    
    IMG_SIGNATURE = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
        //UIImageWriteToSavedPhotosAlbum(IMG_SIGNATURE, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self.library saveImage:IMG_SIGNATURE toAlbum:@"Vinacredit" withCompletionBlock:^(NSError *error) {
        if (error!=nil) {
            NSLog(@"Big error: %@", [error description]);
        }
    }];
    
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:SENDING pushView:TRUE navigationController:self.navigationController];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.dimBackground = YES;
	
        // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
	
        // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
 
}
- (void)myTask{
    sleep(TIME_LOADING);
    
        //ReceiptViewController *receipt = [[ReceiptViewController alloc] initWithNibName:@"ReceiptViewController" bundle:[NSBundle mainBundle]];
        //[self.navigationController pushViewController:receipt  animated:YES];

}

- (IBAction)clear {
        //self.drawImage = nil;
    [self drawSquiggly:nil];
}


#pragma Draw
- (void)drawFreeformLineHandler:(UIPanGestureRecognizer *)sender {
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (!freeformLayer) {
            freeformLineDrawer = [[FreeformLineDrawer alloc] initWithStartPoint:[sender locationInView:self.drawImage]];
            freeformLayer = [[CALayer alloc] init];
            freeformLayer.frame = self.drawImage.bounds; //do not capture view's offset in it's superview
            freeformLayer.delegate = freeformLineDrawer; //ask the freeform drawer object to handle all kinds of drawing
            [self.drawImage.layer addSublayer:freeformLayer];
        } else {
            [freeformLineDrawer startNewPoint:[sender locationInView:self.drawImage]];
        }
        
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
            //start drawin lines baby...
        [freeformLineDrawer updatePoint:[sender locationInView:self.drawImage]];
        [freeformLayer setNeedsDisplay];
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
            //additionally, a callback here can be specified to query the freeformLineDrawer object to extract points
    }
}

- (IBAction)drawSquiggly:(id)sender {
    [freeformLayer removeFromSuperlayer];
    freeformLayer = nil; //remove previous lines
    freeformLineDrawer = nil;
    [self.view removeGestureRecognizer:panGestureRecognizer]; //remove old recognizer if it exists
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drawFreeformLineHandler:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
}
@end
