//
//  SumBill.m
//  Demo
//
//  Created by Vinacredit on 9/28/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "SumBill.h"


@implementation SumBill
@synthesize dateSale = _dateSale;
@synthesize sumBill = _sumBill;
@synthesize bill = _bill;
@synthesize emailSumBill = _emailSumBill;
-(id)initWithDateSale:(NSString *)dateSale sumBill:(NSString *)sumBill bill:(Bill *)bill emailSumBill:(NSString *)emailSumBill{
    self = [super init];
    if(self){
        self.dateSale = dateSale;
        self.sumBill = sumBill;
        self.bill = bill;
        self.emailSumBill = emailSumBill;
    }
    return self;
}

@end
