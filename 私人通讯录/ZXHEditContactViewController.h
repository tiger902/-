//
//  ZXHEditContactViewController.h
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/12.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXHEditContactViewController,ZXHContact;

@protocol ZXHEditContactViewControllerDelegate <NSObject>


@optional
-(void)ZXHEditContactViewController:(ZXHEditContactViewController*)editContactViewController resultOfEditContact:(ZXHContact*)contact;

@end

@interface ZXHEditContactViewController : UIViewController

@property (nonatomic,strong) ZXHContact *contact;

@property (nonatomic,weak) id<ZXHEditContactViewControllerDelegate> delegate;

@end
