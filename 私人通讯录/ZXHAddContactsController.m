//
//  ZXHAddContactsController.m
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/11.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import "ZXHAddContactsController.h"
#import "ZXHContact.h"

@interface ZXHAddContactsController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UIButton *addContactButton;

@end

@implementation ZXHAddContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nameAndPhoneNumberTextFieldDidValueChanged) name:UITextFieldTextDidChangeNotification object:_nameTextField];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nameAndPhoneNumberTextFieldDidValueChanged) name:UITextFieldTextDidChangeNotification object:_phoneNumberTextField];
    
    [self nameAndPhoneNumberTextFieldDidValueChanged];
    
    //self.navigationItem.leftBarButtonItem=nil;
}

-(void)nameAndPhoneNumberTextFieldDidValueChanged{
    
    _addContactButton.enabled=((_nameTextField.text.length==0)||(_phoneNumberTextField.text.length==0))? NO:YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didAddContactButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZXHAddContactsController:ZXHContact:)]) {
        
        ZXHContact *addContact=[[ZXHContact alloc]init];
        
        addContact.name=_nameTextField.text;
        
        addContact.phoneNumber=_phoneNumberTextField.text;
        
        [self.delegate ZXHAddContactsController:self ZXHContact:addContact];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
