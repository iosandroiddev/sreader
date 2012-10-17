//
//  Account.m
//  Demo
//
//  Created by Vinacredit on 9/28/12.
//  Copyright (c) 2012 Vinacredit. All rights reserved.
//

#import "Account.h"

@implementation Account
@synthesize email = _email;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize companyName = _companyName;
@synthesize pass = _pass;
@synthesize imageAcc = _imageAcc;
@synthesize address = _address;
-(id)initWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName companyName:(NSString *)companyName pass:(NSString *)pass imageAcc:(UIImage *)imageAcc address:(NSString *)address{
    self = [super init];
    if(self){
        self.email = email;
        self.firstName = firstName;
        self.lastName = lastName;
        self.companyName = companyName;
        self.pass = pass;
        self.imageAcc = imageAcc;
        self.address = address;
    }
    return self;
}

@end
