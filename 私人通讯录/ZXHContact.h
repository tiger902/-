//
//  ZXHContact.h
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/11.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHContact : NSObject<NSCoding>

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *phoneNumber;

@end
