//
//  ItemCell.m
//  ExampleSale
//
//  Created by Vinacredit on 9/5/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

@synthesize itemNum;
@synthesize itemImage;
@synthesize itemLabel;
@synthesize itemField;
@synthesize buttonMinus;
@synthesize buttonPlus;
@synthesize idx;
@synthesize delegate;


- (IBAction)onMinusUpInside:(id)sender{
        if(delegate && [delegate respondsToSelector:@selector(customized1CellDidMinus:)])
        {
            [delegate customized1CellDidMinus:self];
        }
}
- (IBAction)onPlusUpInside:(id)sender{
        if(delegate && [delegate respondsToSelector:@selector(customized1CellDidPlus:)])
        {
            [delegate customized1CellDidPlus:self];
        }
}
@end
