//
//  WelcomeViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Library.h"
#import "Macros.h"
@implementation WelcomeViewController

- (IBAction)gotoSignIn:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:SIGNIN pushView:TRUE navigationController:self.navigationController];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{    
    
    [super viewDidUnload];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
