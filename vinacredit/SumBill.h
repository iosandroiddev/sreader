//
//  SumBill.h
//  Demo
//
//  Created by Vinacredit on 9/28/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bill.h"
@interface SumBill : NSObject {    
    NSString *_dateSale;
    NSString *_sumBill;
    Bill *__weak _bill;
    NSString *_emailSumBill;
}


@property (nonatomic, copy) NSString *dateSale;
@property (nonatomic, copy) NSString *sumBill;
@property (weak, nonatomic) Bill *bill;
@property (nonatomic, copy) NSString *emailSumBill;

-(id)initWithDateSale:(NSString *)dateSale sumBill:(NSString *)sumBill bill:(Bill *)bill emailSumBill:(NSString *)emailSumBill;

@end
