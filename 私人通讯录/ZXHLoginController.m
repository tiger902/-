//
//  ZXHLoginController.m
//  私人通讯录
//
//  Created by zengxiaohu on 16/4/11.
//  Copyright © 2016年 zengxiaohu. All rights reserved.
//

#import "ZXHLoginController.h"
#import "MBProgressHUD+CZ.h"

@interface ZXHLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UISwitch *remmemberPasswordSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@end

@implementation ZXHLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userNameandPasswordTextFieldValueChanged) name:UITextFieldTextDidChangeNotification object:_userNameTextField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userNameandPasswordTextFieldValueChanged) name:UITextFieldTextDidChangeNotification object:_passwordTextField];
    
    //_loginButton.enabled=((_userNameTextField.text.length==0)||(_passwordTextField.text==0))? NO:YES;
    
    //_userNameTextField.text=@"admin";
    
    //_passwordTextField.text=@"520";
    //NSUserDefaults *userDefaults
    [self UserSettings];
}

-(void)UserSettings{
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    
    BOOL isRememberPassword=[userDefault boolForKey:@"rememberPassword"];
    
    BOOL isAutoLogin=[userDefault boolForKey:@"autoLogin"];
    
    if (isRememberPassword==YES) {
        
        //NSString *userName=[userDefault objectForKey:@"userName"];;
        _userNameTextField.text=[userDefault objectForKey:@"userName"];
        
        _passwordTextField.text=[userDefault objectForKey:@"password"];
        
        
        [_remmemberPasswordSwitch setOn:YES animated:YES];
        
    }else{
        
        [_remmemberPasswordSwitch setOn:NO animated:YES];
    }
    
    if (isAutoLogin==YES) {
        
        [_autoLoginSwitch setOn:YES animated:YES];
        
        [self didClickLoginButton:_loginButton];
        
    }else{
        
        [_autoLoginSwitch setOn:NO animated:YES];
    }
}

-(void)setUserSettings{
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    
    if (_remmemberPasswordSwitch.isOn==YES) {
        
        [userDefault setBool:YES forKey:@"rememberPassword"];
        
        [userDefault setObject:_userNameTextField.text forKey:@"userName"];
        
        [userDefault setObject:_passwordTextField.text forKey:@"password"];
        
    }else{
        
       [userDefault setBool:NO forKey:@"rememberPassword"];
    }
    
    if (_autoLoginSwitch.isOn==YES) {
        
        [userDefault setBool:YES forKey:@"autoLogin"];
        
    } else {
        
        [userDefault setBool:NO forKey:@"autoLogin"];
    }
    
    
}

- (IBAction)didClickLoginButton:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    [MBProgressHUD showMessage:@"正在登陆..." toView:self.navigationController.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if ([_userNameTextField.text isEqualToString:@"admin"]&& [_passwordTextField.text isEqualToString:@"520"]) {
            
            [self setUserSettings];
            
            [self performSegueWithIdentifier:@"login2Contacts" sender:@"520"];
            
            
        } else {
            
            [MBProgressHUD showError:@"对不起，你输入的用户名或密码有误"];
        }
        
    });
    
    
}

- (IBAction)rememberSwitchValueChanged:(UISwitch *)sender {
    
    if (sender.isOn==NO) {
      
        [_autoLoginSwitch setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginSwitchValueChanged:(UISwitch *)sender {
    
    if (sender.isOn) {
        
        [_remmemberPasswordSwitch setOn:YES animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)userNameandPasswordTextFieldValueChanged{
    
    if ((_userNameTextField.text.length==0)||(_passwordTextField.text.length==0)) {
        
        _loginButton.enabled=NO;
        
    } else {
        
        _loginButton.enabled=YES;
    
    }
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *viewController=segue.destinationViewController;
    
    viewController.title=[NSString stringWithFormat:@"%@的联系人",_userNameTextField.text];
}


@end
