//
//  ZXHAddContactsController.h
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/11.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXHContact,ZXHAddContactsController;

@protocol ZXHAddContactsControllerDelegate <NSObject>

@optional

-(void)ZXHAddContactsController:(ZXHAddContactsController*)addContactsController ZXHContact:(ZXHContact*)contact;

@end

@interface ZXHAddContactsController : UIViewController

@property (nonatomic,weak) id<ZXHAddContactsControllerDelegate> delegate;

@end
