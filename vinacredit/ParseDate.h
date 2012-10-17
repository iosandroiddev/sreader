//
//  ParseDate.h
//  vinacredit
//
//  Created by Vinacredit on 9/29/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseDate : NSObject
{
    NSString *_E;
    NSString *_day;
    NSString *_month;
    NSString *_year;
    NSString *_hour;
    NSString *_minute;
    
}

@property (nonatomic, strong) NSString *E;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *minute;
-(NSString *)getCurrentDate;
-(NSString *)getCurrentTime;
@end
