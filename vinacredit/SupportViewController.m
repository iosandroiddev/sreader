//
//  SupportViewController.m
//  vinacredit
//
//  Created by Vinacredit on 8/17/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "SupportViewController.h"
#import "Library.h"
#import "Macros.h"
@interface SupportViewController ()

@end

@implementation SupportViewController
@synthesize gotoInstruc;
@synthesize gotoVinacredit;
@synthesize gotoNumber;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SUPPORT_LBL;
    [gotoInstruc setTitle:SUPPORT_INSTRU_LBL forState:UIControlStateNormal];
    [gotoNumber setTitle:SUPPORT_HOTLINE_LBL forState:UIControlStateNormal];
    [gotoVinacredit setTitle:SUPPORT_VINA_LBL forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    gotoVinacredit = nil;
    gotoNumber = nil;
    gotoInstruc = nil;
    [self setGotoVinacredit:nil];
    [self setGotoNumber:nil];
    [self setGotoInstruc:nil];
    [self setGotoInstruc:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gotoVinacredit:(id)sender {
}

- (IBAction)gotoNumber:(id)sender {
}

- (IBAction)gotoInstruc:(id)sender {
}

- (IBAction)gotoAccount:(id)sender {
    Library *lib = [[Library alloc]init];
    [lib gotoInterFace:ACCOUNT pushView:TRUE navigationController:self.navigationController];
}
@end
