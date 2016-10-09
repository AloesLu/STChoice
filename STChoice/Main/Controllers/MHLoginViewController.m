//
//  MHLoginViewController.m
//  vomoho
//
//  Created by Xmac on 16/1/14.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHLoginViewController.h"
#import "MHModifyPwdViewController.h"

@interface MHLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *phonePic;
@property (weak, nonatomic) IBOutlet UILabel *passPic;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *freeLoginButton; // 免费注册
@property (weak, nonatomic) IBOutlet UIButton *forgetButton; // 忘记密码
@property (weak, nonatomic) IBOutlet UIButton *weixinPicB;
@property (weak, nonatomic) IBOutlet UIButton *QQPicB;
@property (weak, nonatomic) IBOutlet UIButton *weiboPicB;
@property (weak, nonatomic) IBOutlet UIButton *eyePicB;
@property(nonatomic,assign)BOOL isEye;

@property (strong, nonatomic)UITapGestureRecognizer *tapView;
@end

@implementation MHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    _isEye=YES;
    [_eyePicB setTitle:@"\U0000e6c5" forState:UIControlStateNormal];
    [self initParamValue];
    if(!_isBack){
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:[MHGlobalFunction getWordNavBarButton:@""]];
//        UIButton *button=[MHGlobalFunction getWordNavBarButton:@"跳过"];
//        [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    }
    
    [[ST_NetAPIManager sharedManager]request_timeList_WithTimeStatus:[NSNumber numberWithInt:1] andBlock:^(id data, NSError *error) {
        if(data){
            NSMutableArray *arry=data;
            if(arry.count>0){
                [[MHAdminManager sharedManager]setKNowTimeSection:[data objectAtIndex:0]];
            }else{
                [[MHAdminManager sharedManager]setKNowTimeSection:nil];
            }
        }
    }];
}

//- (void)jump{
//    [appMHDelegate loginApp];
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addGestureRecognizer:self.tapView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view removeGestureRecognizer:self.tapView];
}

- (void)clickView{
    [self.view endEditing:YES];
}

- (void)initParamValue{
    self.tapView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
    
    self.phonePic.text=@"\U0000e6c3";
    self.passPic.text=@"\U0000e6c1";
    [self.weixinPicB setTitle:@"\U0000e661" forState:UIControlStateNormal];
    [self.weixinPicB setTitleColor:kDescribeColor forState:UIControlStateNormal];
    [self.weixinPicB setTitleColor:kMainColorIcon forState:UIControlStateHighlighted];
    [self.QQPicB setTitle:@"\U0000e65f" forState:UIControlStateNormal];
    [self.QQPicB setTitleColor:kDescribeColor forState:UIControlStateNormal];
    [self.QQPicB setTitleColor:kMainColorIcon forState:UIControlStateHighlighted];
    [self.weiboPicB setTitle:@"\U0000e660" forState:UIControlStateNormal];
    [self.weiboPicB setTitleColor:kDescribeColor forState:UIControlStateNormal];
    [self.weiboPicB setTitleColor:kMainColorIcon forState:UIControlStateHighlighted];
    
    self.loginButton.enabled=NO;
    
    self.phoneTextField.delegate=self;
    self.phoneTextField.tag=1001;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:self.phoneTextField];
    self.passTextField.delegate=self;
    self.passTextField.tag=1002;
    [self.passTextField setSecureTextEntry:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:self.passTextField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if(textField.tag==1001){
//        if(textField.text.length!=11){
//            [MHGlobalFunction showHUD:@"手机号格式有误"];
//        }
//    }
//    if(textField.tag==1002){
//        if(textField.text.length<6){
//            [MHGlobalFunction showHUD:@"密码不能少于六位"];
//        }
//    }
}

/**
 *  自定义监听
 *
 *  @param obj 监听对象
 */
- (void)textFieldEditChanged:(NSNotification *)obj{
    if(self.phoneTextField.text.length>=4&&self.passTextField.text.length>=4){
        self.loginButton.backgroundColor=kMainColor;
        [self.loginButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        self.loginButton.enabled=YES;
    }else{
        self.loginButton.backgroundColor=kDescribeColor;
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.enabled=NO;
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 登录按钮的点击事件
- (IBAction)loginButtonAction:(id)sender {
    NSString *phone=self.phoneTextField.text;
    NSString *pwd=self.passTextField.text;
    if([[phone substringToIndex:2] isEqualToString:@"12"]){
        [[ST_NetAPIManager sharedManager]request_studentLogin_WithStuId:phone pwd:pwd andBlock:^(id data, NSError *error) {
            if(data){
                [[MHStudentManager sharedManager]setStudentData:data];
                [[MHStudentManager sharedManager]setkUserDefaults_isSubmitWish:[NSNumber numberWithInt:0]];
                [appMHDelegate loginApp:2];
                [MHGlobalFunction showHUD:@"登陆成功"];
            }else{
                [MHGlobalFunction showHUD:@"登陆失败"];
            }
        }];
    }else if([[phone substringToIndex:2] isEqualToString:@"20"]){
        [[ST_NetAPIManager sharedManager]request_teacherLogin_WithTeaId:phone pwd:pwd andBlock:^(id data, NSError *error) {
            if(data){
                [[MHTeacherManager sharedManager]setTeacherData:data];
                [appMHDelegate loginApp:3];
                [MHGlobalFunction showHUD:@"登陆成功"];
            }else{
                [MHGlobalFunction showHUD:@"登陆失败"];
            }
        }];
    }else if([[phone substringToIndex:2] isEqualToString:@"66"]||[phone isEqualToString:@"admin"]){
        [[ST_NetAPIManager sharedManager]request_adminLogin_WithAdminId:phone pwd:pwd andBlock:^(id data, NSError *error) {
            if([data isEqualToString:@"成功"]){
                [appMHDelegate loginApp:1];
                [MHGlobalFunction showHUD:@"登陆成功"];
            }else{
                [MHGlobalFunction showHUD:@"登陆失败"];
            }
        }];
    }
}
// 眼睛的点击事件
- (IBAction)eyeAction:(id)sender {
    if (_isEye == YES) {
        [_passTextField setSecureTextEntry:YES];
        [_eyePicB setTitle:@"\U0000e6c5" forState:UIControlStateNormal];
        _isEye = NO;
    }else{
        [_passTextField setSecureTextEntry:NO];
        [_eyePicB setTitle:@"\U0000e6c6" forState:UIControlStateNormal];
        _isEye = YES;
    }
}
// 免费注册按钮的点击事件
- (IBAction)freeLoginButtonAction:(id)sender {
}
// 忘记密码按钮点击事件
- (IBAction)forgetButtonAction:(id)sender {
    NSString *phone=self.phoneTextField.text;
    if(phone.length<3){
        [MHGlobalFunction showHUD:@"请输入正确工号或学号"];
        return ;
    }
    if([[phone substringToIndex:2] isEqualToString:@"12"]){
        MHModifyPwdViewController *mpVC=[[MHModifyPwdViewController alloc]init];
        mpVC.roleType=@"学生";
        mpVC.userId=phone;
        MHBaseNavigationController *nav=[[MHBaseNavigationController alloc]initWithRootViewController:mpVC];
        [self.parentViewController presentViewController:nav animated:YES completion:nil];
    }else if([[phone substringToIndex:2] isEqualToString:@"20"]){
        MHModifyPwdViewController *mpVC=[[MHModifyPwdViewController alloc]init];
        mpVC.roleType=@"教师";
        mpVC.userId=phone;
        MHBaseNavigationController *nav=[[MHBaseNavigationController alloc]initWithRootViewController:mpVC];
        [self.parentViewController presentViewController:nav animated:YES completion:nil];
    }else if([[phone substringToIndex:2] isEqualToString:@"66"]||[phone isEqualToString:@"admin"]){
        MHModifyPwdViewController *mpVC=[[MHModifyPwdViewController alloc]init];
        mpVC.roleType=@"管理员";
        mpVC.userId=phone;
        MHBaseNavigationController *nav=[[MHBaseNavigationController alloc]initWithRootViewController:mpVC];
        [self.parentViewController presentViewController:nav animated:YES completion:nil];
    }else{
        [MHGlobalFunction showHUD:@"请输入工号或学号"];
    }
}
// 微信图像按钮和文字按钮的点击事件
- (IBAction)weixinButtonAction:(id)sender {
    
}
// QQ头像按钮和文字按钮的点击事件
- (IBAction)QQButtonAction:(id)sender {
}
// 微博图像按钮和文字按钮的点击事件
- (IBAction)weiboButtonAction:(id)sender {
}

@end
