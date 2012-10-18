//
//  ConnectDatabase.m
//  Demo
//
//  Created by Vinacredit on 9/28/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "ConnectDatabase.h"

@implementation ConnectDatabase

static ConnectDatabase *_database;


+(ConnectDatabase *)database {
    if (_database == nil) {
        _database = [[ConnectDatabase alloc] init];
    }
    return _database;
}

-(id)init {
    if ((self = [super init])) {
        NSString *fileName = @"database.sqlite";
        NSString *dbDocPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), fileName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:dbDocPath]) {
            NSString *dbBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
            NSError *error = nil;
            [fileManager copyItemAtPath:dbBundlePath toPath:dbDocPath error:&error];
            if (error) {
                NSLog(@"Check Database Error: %@", error.description);
            }
        }
        if(sqlite3_open([dbDocPath UTF8String], &_database) != SQLITE_OK){
            NSLog(@"Failed to open database!");
        }
    
    }
    return self;
}

-(void)dealloc {
    sqlite3_close(_database);
}
-(NSArray *)sumBill:(NSString *)email{
    char *error;
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    //NSString *query = [NSString stringWithFormat:@"SELECT * FROM SumBill WHERE email=\"%@\" ORDER BY Id DESC", email];
    NSString *que = [NSString stringWithFormat:@"SELECT * FROM SumBill WHERE email=\"%@\" ORDER BY rowid DESC", email];
    NSString *update = [NSString stringWithFormat:@"UPDATE SumBill SET sumBill = (select sum(Bill.sumItem) from Bill where SumBill.email = Bill.email and SumBill.dateSale = Bill.dateSale)"];
    if( sqlite3_exec(_database, [update UTF8String], NULL, NULL, &error) == SQLITE_OK )
        {
            NSLog(@"SumBill update successful.");
        }
        else
        {
            NSLog(@"Error: %s", error);
        }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [que UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {            
            char *dateChars = (char *) sqlite3_column_text(statement, 0);
            char *sumChars = (char *) sqlite3_column_text(statement, 1);
            char *emailChars = (char *) sqlite3_column_text(statement, 2);
            NSString *dateString = [[NSString alloc] initWithUTF8String:dateChars];
            NSString *sum = [[NSString alloc] initWithUTF8String:sumChars];
            NSString *email = [[NSString alloc] initWithUTF8String:emailChars];
            Bill *bill = [[Bill alloc] initWithTimeSale:nil sumItem:nil emailBill:email dateSale:dateString];
            SumBill *sumbill = [[SumBill alloc] initWithDateSale:dateString sumBill:sum bill:bill emailSumBill:email];
            [retval addObject:sumbill];
        }
        sqlite3_finalize(statement);
    }
    return retval;
}
-(NSArray *)bills:(NSString *)currentDate email:(NSString *)email{
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Bill WHERE dateSale=\"%@\" and email=\"%@\"  ORDER BY rowid DESC", currentDate,email];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {            
            char *timeChars = (char *) sqlite3_column_text(statement, 0);
            char *sumChars = (char *) sqlite3_column_text(statement, 1);
            char *emailChars = (char *) sqlite3_column_text(statement, 2);
            char *dateChars = (char *) sqlite3_column_text(statement, 3);
            NSString *timeString = [[NSString alloc] initWithUTF8String:timeChars];
            NSString *sumString = [[NSString alloc] initWithUTF8String:sumChars];
            NSString *emailString = [[NSString alloc] initWithUTF8String:emailChars];
            NSString *dateString = [[NSString alloc] initWithUTF8String:dateChars];
            Bill *bill = [[Bill alloc] initWithTimeSale:timeString sumItem:sumString emailBill:emailString dateSale:dateString];
            [retval addObject:bill];
        }
        sqlite3_finalize(statement);
    }
    return retval;
}

-(BOOL)isCheckEmail:(NSString *)email {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT email FROM SumBill "];
    sqlite3_stmt *statement;
    if(sqlite3_prepare(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *emailChars = (char *) sqlite3_column_text(statement, 0);
            NSString *emailString = [[NSString alloc] initWithUTF8String:emailChars];
            [array addObject:emailString];
        }
        sqlite3_finalize(statement);
    }
    for (NSString *item in array) {
        if([email isEqualToString:item]) {
            return TRUE;
            break;
        }
    }
    return FALSE;
}

-(BOOL)isCheckDate:(NSString *)currentDate email:(NSString *)email {
    NSMutableArray *array = [[NSMutableArray alloc] init];    
    NSString *query = [NSString stringWithFormat:@"SELECT dateSale FROM SumBill WHERE email=\"%@\"",email];
    sqlite3_stmt *statement;
    if(sqlite3_prepare(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *dateChars = (char *) sqlite3_column_text(statement, 0);
            NSString *dateString = [[NSString alloc] initWithUTF8String:dateChars];
            [array addObject:dateString];
        }
        sqlite3_finalize(statement);
    }
    for (NSString *item in array) {
        if([currentDate isEqualToString:item]) {
            return TRUE;
            break;
        }
    }
    return FALSE;
}

-(void)insertBill:(SumBill *)sumbill currentDate:(NSString *)currentDate email:(NSString *)email{
    char *error;
    if([self isCheckDate:currentDate email:email] && [self isCheckEmail:email])
    {
        
        NSString *insertBill = [NSString stringWithFormat:@"INSERT INTO Bill (timeSale, sumItem,email,dateSale) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", sumbill.bill.timeSale, sumbill.bill.sumItem, email, currentDate];
        if ( sqlite3_exec(_database, [insertBill UTF8String], NULL, NULL, &error) == SQLITE_OK )
        {
            NSLog(@"SumBill inserted.");
        }
        else
        {
            NSLog(@"Error: %s", error);
        }
    } else {
    // Create insert statement for the SumBill
    NSString *insertSumBill = [NSString stringWithFormat:@"INSERT INTO SumBill (dateSale, sumBill, email) VALUES (\"%@\", \"%@\", \"%@\")", sumbill.dateSale,sumbill.sumBill,sumbill.emailSumBill];

    if ( sqlite3_exec(_database, [insertSumBill UTF8String], NULL, NULL, &error) == SQLITE_OK)
    {        
        
        // Create insert statement for the bill in sumbill
            NSString *insertBill = [NSString stringWithFormat:@"INSERT INTO Bill (timeSale, sumItem, email, dateSale) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", sumbill.bill.timeSale, sumbill.bill.sumItem, email,currentDate];
        if ( sqlite3_exec(_database, [insertBill UTF8String], NULL, NULL, &error) == SQLITE_OK)
        {
            NSLog(@"SumBill inserted.");
        }
        else
        {
            NSLog(@"Error: %s", error);
        }
    }
    else
    {
        NSLog(@"Error: %s", error);
    }
}
}

-(void)insertAcc:(Account *)account {
    // Create insert statement for the Acc
    NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO Account (email, firstName, lastName, companyName, pass, imageAcc, address) VALUES (?,?,?,?,?,?,?)"];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(_database, [insertStatement UTF8String], -1, &statement, nil) == SQLITE_OK){
        
        sqlite3_bind_text(statement, 1, [account.email UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [account.firstName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [account.lastName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [account.companyName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [account.pass UTF8String], -1, SQLITE_TRANSIENT);
        NSData *data = UIImagePNGRepresentation(account.imageAcc);
        sqlite3_bind_blob(statement, 6, [data bytes], [data length], NULL);
        sqlite3_bind_text(statement, 7, [account.address UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_step(statement);
        NSLog(@"Add successful");
    }
}
-(Account *)selectAcc:(NSString *)email{
    UIImage *image = nil;
    Account *acc = [[Account alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Account WHERE email=\"%@\"", email];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            acc.email = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            acc.firstName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            acc.lastName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            acc.companyName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            acc.pass = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];            
            int imaLen = sqlite3_column_bytes(statement, 5);
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(statement, 5) length:imaLen];
            image = [[UIImage alloc] initWithData:data];
            acc.imageAcc = image;
            acc.address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            
        }
        sqlite3_finalize(statement);
    }
    return acc;
}
@end
