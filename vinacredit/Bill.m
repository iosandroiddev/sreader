//
//  Bill.m
//  Demo
//
//  Created by Vinacredit on 9/28/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "Bill.h"

@implementation Bill

@synthesize timeSale = _timeSale;
@synthesize sumItem = _sumItem;
@synthesize emailBill = _emailBill;
@synthesize dateSale = _dateSale;
-(id)initWithTimeSale:(NSString *)timeSale sumItem:(NSString *)sumItem emailBill:(NSString *)emailBill dateSale:(NSString *)dateSale{
    self = [super init];
    if(self){
        self.timeSale = timeSale;
        self.sumItem = sumItem;
        self.emailBill = emailBill;
        self.dateSale = dateSale;
    }
    return self;
}

@end
