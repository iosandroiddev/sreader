//
//  ParseDate.m
//  vinacredit
//
//  Created by Vinacredit on 9/29/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "ParseDate.h"
#import "Macros.h"
@implementation ParseDate
@synthesize E = _E;
@synthesize day = _day;
@synthesize month = _month;
@synthesize year = _year;
@synthesize hour = _hour;
@synthesize minute = _minute;

//convert NSDate to NSString
-(void) parseDate
{
    NSString *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE,dd-MM-yyyy HH:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"VietNam"]];

    // create a string of current date & time using NSDateFormatter
    date = [formatter stringFromDate:[NSDate date]];
    if(DEBUG_SCR)NSLog(@"------date :%@",date);
    date = [date stringByReplacingOccurrencesOfString:@"," withString:@""];
    date = [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    date = [date stringByReplacingOccurrencesOfString:@" " withString:@""];
    date = [date stringByReplacingOccurrencesOfString:@":" withString:@""];
    if(DEBUG_SCR)NSLog(@"------date :%@",date);
    
    _E = [date substringWithRange:NSMakeRange(0,3)];
    _day = [date substringWithRange:NSMakeRange (3, 2)];
    _month = [date substringWithRange:NSMakeRange (5, 2)];
    _year = [date substringWithRange:NSMakeRange (7, 4)];
    _hour = [date substringWithRange:NSMakeRange (11, 2)];
    _minute = [date substringWithRange:NSMakeRange (13, 2)];

}
-(NSString *)getCurrentDate{
    [self parseDate];
    return [NSString stringWithFormat:@"%@,%@-%@-%@",_E,_day,_month,_year];
}
-(NSString *)getCurrentTime {
    
    [self parseDate];
    return [NSString stringWithFormat:@"%@:%@",_hour,_minute];
}
@end
