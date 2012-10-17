//
//  Cell.m
//  vinacredit
//
//  Created by Vinacredit on 9/27/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "Cell.h"

@implementation Cell
@synthesize image;
@synthesize bill;
@synthesize time;
@synthesize sumItem;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
