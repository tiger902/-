//
//  ZXHContact.m
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/11.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import "ZXHContact.h"

@implementation ZXHContact

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_name forKey:@"name"];
    
    [aCoder encodeObject:_phoneNumber forKey:@"phoneNumber"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self=[super init]) {
        
        _name=[aDecoder decodeObjectForKey:@"name"];
        
        _phoneNumber=[aDecoder decodeObjectForKey:@"phoneNumber"];
    }
    
    return self;
}

@end
