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
    self.title = @"Support";
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
