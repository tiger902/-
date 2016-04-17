//
//  ZXHEditContactViewController.m
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/12.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import "ZXHEditContactViewController.h"
#import "ZXHContact.h"

@interface ZXHEditContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveContactButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButtonItem;

@end

@implementation ZXHEditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameTextField.text=self.contact.name;
    _phoneNumberTextField.text=self.contact.phoneNumber;
    
    _phoneNumberTextField.enabled=NO;
    _nameTextField.enabled=NO;
    
    _saveContactButton.hidden=YES;
}
- (IBAction)didClicksaveContactButton:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(ZXHEditContactViewController:resultOfEditContact:)]) {
        
        ZXHContact *contact=[[ZXHContact alloc]init];
        
        contact.name=_nameTextField.text;
        contact.phoneNumber=_phoneNumberTextField.text;
       
        [self.delegate ZXHEditContactViewController:self resultOfEditContact:contact];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickEditOrNotButton:(UIBarButtonItem*)sender {
    
    if (_saveContactButton.hidden==YES) {
        
        sender.title=@"取消";
        
        _nameTextField.enabled=YES;
        
        _phoneNumberTextField.enabled=YES;
        
        _saveContactButton.hidden=NO;
        
        
    } else {
        
        sender.title=@"编辑";
        
        _nameTextField.enabled=NO;
        
        _phoneNumberTextField.enabled=NO;
        
        _nameTextField.text=self.contact.name;
        _phoneNumberTextField.text=self.contact.phoneNumber;
        
        _saveContactButton.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
