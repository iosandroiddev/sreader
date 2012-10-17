//
//  CellData.m
//  Sale
//
//  Created by Vinacredit on 9/19/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "CellData.h"

@implementation CellData
@synthesize labelItem;
@synthesize textItem;
@synthesize imageItem;
@synthesize numItem;
- (id)init
{
    self = [super init];
    if (self) {
        self.labelItem = @"0";
        self.textItem = textItem;
        self.imageItem = imageItem;
        self.numItem = @"1x";
    }
    return self;
}
@end
