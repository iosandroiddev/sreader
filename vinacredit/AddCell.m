//
//  AddCell.m
//  Sale
//
//  Created by Vinacredit on 9/19/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "AddCell.h"

@implementation AddCell
@synthesize imageItem;
@synthesize textItem;
@synthesize labelItem;
@synthesize delegate;
@synthesize adx;

BOOL bTestPrice;
- (IBAction)onAddUpInside:(id)sender{
    bTestPrice = TRUE;
        // lableItem is 0
    if ([labelItem.text isEqualToString:@"0"])
        bTestPrice = FALSE;
        //if lableItem isn't 0, action.
    if (bTestPrice){
        if(delegate && [delegate respondsToSelector:@selector(addCellDidAdd:)]){
            [delegate addCellDidAdd:self];
        }
    }
    
}

@end
