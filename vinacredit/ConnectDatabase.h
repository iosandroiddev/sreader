//
//  ConnectDatabase.h
//  Demo
//
//  Created by Vinacredit on 9/28/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Bill.h"
#import "SumBill.h"
#import "Account.h"
@interface ConnectDatabase : NSObject {
    sqlite3 *_database;
}

+(ConnectDatabase *)database;

-(NSArray *)sumBill:(NSString *)email;
-(NSArray *)bills:(NSString *)currentDate email:(NSString *)email;

-(void)insertBill:(SumBill *)sumbill currentDate:(NSString *)currentDate email:(NSString *)email;
-(void)insertAcc:(Account *)account;
-(BOOL)isCheckDate:(NSString *)currentDate email:(NSString *)email;
-(BOOL)isCheckEmail:(NSString *)email;
-(Account *)selectAcc:(NSString *)email;
@end
