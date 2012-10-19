//
//  TaxViewController.m
//  vinacredit
//
//  Created by Vinacredit on 9/12/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "TaxViewController.h"
#import "Library.h"
#import "Macros.h"
@implementation TaxViewController
@synthesize swit, label, image;

NSString *tmpTax = @"0 %";
NSString* strSwitchControl;
- (void)viewDidLoad
{
    [super viewDidLoad];
    swit = [[UISwitch alloc] initWithFrame:CGRectZero];
    [swit setOn:NO animated:NO];
    if(BUILD_IPHONE_OR_IPAD)
        label = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 5.0f, 79.0f, 27.0f)];
    else
        label = [[UILabel alloc] initWithFrame:CGRectMake(620.0f, 5.0f, 79.0f, 27.0f)];
    label.textAlignment = UITextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];    
    label.text = TAX_RATE_VALUE;
    
    self.title = @"Tax";
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // Return the number of rows in the section.
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	
	return @"Add a percentage to you payments to account for state taxes.";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
	}
    if(indexPath.row == 0){
        cell.textLabel.text = @"Add Sale Tax";
        cell.accessoryView = swit;

        if(!TAX_STATUS_VALUE)
            [swit setOn:NO animated:NO];
        else
            [swit setOn:YES animated:NO];
        
        [swit addTarget:self action:@selector(statusSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Tax Rate";
        [cell addSubview:label];
            //[cell addSubview:image];
    }
    return cell;
}

- (void) statusSwitchChanged:(id)sender {
    UISwitch* switchControl = sender;
    strSwitchControl = switchControl.on ? @"ON" : @"OFF";
    if([strSwitchControl isEqualToString:@"ON"])
        TAX_STATUS_VALUE = TRUE;
    else
        TAX_STATUS_VALUE = FALSE;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (IBAction)digitPressed:(UIButton *)sender {
    tmpTax=[tmpTax stringByReplacingOccurrencesOfString:@" %" withString:@""];
    
    BOOL bTestDotNumber = FALSE;
    NSString *strDotTax;
    NSString *tmpstrTax = tmpTax;
    
    int i = 1;
    int j = tmpstrTax.length;
    while(i <= j){
        strDotTax = [tmpstrTax substringToIndex:1];
        if([strDotTax isEqualToString:@"."]){
            bTestDotNumber = TRUE;
            break;
        }
        tmpstrTax = [tmpstrTax substringFromIndex:1];
        i ++;
    }
        // user press dot
    BOOL bUserPressDot = FALSE;
    if([[sender currentTitle] isEqualToString:@"."])
        bUserPressDot = TRUE;
    
        // if number had dot and user press dot.
    if(bUserPressDot == TRUE && bTestDotNumber == TRUE)
        return;

        // if number is zero and user press dot.
    BOOL btmpTaxZero = FALSE;
    btmpTaxZero = [tmpTax isEqualToString:@"0"];
    if(bUserPressDot == TRUE && btmpTaxZero == TRUE){
        return;
    }        
    
    if(![@"0 %" isEqualToString:label.text])
        tmpTax = [tmpTax stringByAppendingString:[sender currentTitle]];
    else
        tmpTax = [sender currentTitle];
    
    float tmpfloatTax = [tmpTax floatValue];
    if(tmpfloatTax > 100)
        tmpTax = @"100";
    if(tmpTax.length > 5)
        return;
    
    label.text = [tmpTax stringByAppendingString:@" %"];
    TAX_RATE_VALUE = label.text;
}

- (IBAction)clear {
    tmpTax=label.text;
    tmpTax=[tmpTax stringByReplacingOccurrencesOfString:@" %" withString:@""];
    if (tmpTax.length > 1) {
        tmpTax = [tmpTax substringToIndex:tmpTax.length -1];  
    }
    else 
        tmpTax = @"0";

    NSLog(@"tmp : %@",tmpTax);
    label.text = [tmpTax stringByAppendingString:@" %"];
    TAX_RATE_VALUE = label.text;
}
@end
