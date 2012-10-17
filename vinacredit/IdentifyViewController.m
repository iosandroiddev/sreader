//
//  IdentifyViewController.m
//  vinacredit
//
//  Created by Vinacredit on 1/10/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "IdentifyViewController.h"
#import "Library.h"
#import "Macros.h"
@implementation IdentifyViewController
@synthesize img;

- (void)viewDidLoad
{
    
    //==========================
    self.title = @"Identify";
    //create an add right button
    UIBarButtonItem *addleftButton = [[UIBarButtonItem alloc] initWithTitle:@"Signature" style:UIBarButtonItemStyleBordered target:self action:@selector(Signature:)];
    self.navigationItem.rightBarButtonItem = addleftButton;	
	self.navigationController.delegate = self;
    UIBarButtonItem *btnbackBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pushBackButton:)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = btnbackBar;
    
    //==========================
    
    if(BUILD_IPHONE_OR_IPAD)
        [self imageIdentify];
        //img.image = [UIImage imageNamed:@"chomsao.jpeg"];
        //    img.image = tmpImg;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    img = nil;
    [self setImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)loadImage{
        //img.image =
}
- (void)imageIdentify{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Action Sheet"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo",@"Choose Photo",@"Delete Photo", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 2) {
        img.image = nil;        
    }
    else
        {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        
        if(buttonIndex == 0)
            {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:imagePicker animated:YES];
            }
        if(buttonIndex ==1)
            {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO)
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentModalViewController:imagePicker animated:YES];
            }
        
        }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    img.image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissModalViewControllerAnimated:YES];
        //NSLog(@"test image picker");        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)Signature:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:SIGNATURE pushView:TRUE navigationController:self.navigationController];
}
- (void)pushBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
