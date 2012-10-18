//
//  Account.h
//  Demo
//
//  Created by Vinacredit on 9/28/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//
// take information of Account
#import <Foundation/Foundation.h>

@interface Account : NSObject {
    NSString *_email;
    NSString *_firstName;
    NSString *_lastName;
    NSString *_companyName;
    NSString *_pass;
    UIImage  *_imageAcc;
    NSString *_address;
}

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *pass;
@property (copy, nonatomic) UIImage *imageAcc;
@property (nonatomic, copy) NSString *address;
-(id)initWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName companyName:(NSString *)companyName pass:(NSString *)pass imageAcc:(UIImage *)imageAcc address:(NSString *)address;

@end
