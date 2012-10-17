//
//  Bill.h
//  Demo
//
//  Created by Vinacredit on 9/28/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bill : NSObject {
    
    NSString *_timeSale;
    NSString *_sumItem;
    NSString *_emailBill;
    NSString *_dateSale;
}

@property (nonatomic, copy) NSString *timeSale;
@property (nonatomic, copy) NSString *sumItem;
@property (nonatomic, copy) NSString *emailBill;
@property (nonatomic, copy) NSString *dateSale;
-(id)initWithTimeSale:(NSString *)timeSale sumItem:(NSString *)sumItem emailBill:(NSString *)emailBill dateSale:(NSString *)dateSale;

@end
