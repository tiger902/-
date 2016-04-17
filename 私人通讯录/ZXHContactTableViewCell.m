//
//  ZXHContactTableViewCell.m
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/11.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import "ZXHContactTableViewCell.h"
#import "ZXHContact.h"

@interface ZXHContactTableViewCell()

@property (nonatomic,weak) UIView *separateView;

@end

@implementation ZXHContactTableViewCell

-(void)setContact:(ZXHContact *)contact{
    
    _contact=contact;
    
    self.textLabel.text=_contact.name;
    
    self.detailTextLabel.text=_contact.phoneNumber;
}

- (void)awakeFromNib {
    // Initialization code
    
    UIView *separateView=[[UIView alloc]init];
    
    separateView.backgroundColor=[UIColor blackColor];
    
    separateView.alpha=0.5;
    
    [self addSubview:separateView];
    
    _separateView=separateView;
    
    //self.selected=YES;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat h=1.0f;
    CGFloat w=self.bounds.size.width;
    CGFloat x=0;
    CGFloat y=self.bounds.size.height-h;
    
    [_separateView setFrame:CGRectMake(x, y, w, h)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
