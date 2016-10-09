//
//  MHModifyPwdViewController.m
//  STChoice
//
//  Created by AloesLu on 16/5/23.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHModifyPwdViewController.h"

@interface MHModifyPwdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phonePic;
@property (weak, nonatomic) IBOutlet UILabel *passPic;
@property (weak, nonatomic) IBOutlet UILabel *newpassPic;
@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNewpassTextField;
@property (strong, nonatomic)UITapGestureRecognizer *tapView;
@end

@implementation MHModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=[NSString stringWithFormat:@"%@修改密码",self.roleType];
    self.phonePic.text=@"\U0000e6c3";
    self.passPic.text=@"\U0000e6c1";
    self.newpassPic.text=@"\U0000e6cb";
    UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"取消" rect:CGRectMake(0, 0, 50, 40) size:15];
    [button setTitleColor:kLeadColor forState:UIControlStateNormal];
    [button setTitleColor:nil forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.tapView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
    
    self.userIdTextField.text=self.userId;
}

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

- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addUser:(id)sender {
    NSString *stuId=self.userIdTextField.text;
    NSString *pwd=self.userPwdTextField.text;
    NSString *newPwd=self.userNewpassTextField.text;
    if([self.roleType isEqualToString:@"管理员"]){
        [[ST_NetAPIManager sharedManager]request_modifyAdminPwd_WithAdminId:stuId pwd:pwd newPwd:newPwd andBlock:^(id data, NSError *error) {
            if([data isEqualToString:@"成功"]){
                [MHGlobalFunction showHUD:@"管理员密码修改成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [MHGlobalFunction showHUD:@"修改失败"];
            }
        }];
    }else if([self.roleType isEqualToString:@"学生"]){
        [[ST_NetAPIManager sharedManager]request_modifyStudentPwd_WithStuId:stuId pwd:pwd newPwd:newPwd andBlock:^(id data, NSError *error) {
            if([data isEqualToString:@"成功"]){
                [MHGlobalFunction showHUD:@"学生密码修改成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [MHGlobalFunction showHUD:@"修改失败"];
            }
        }];
    }else if([self.roleType isEqualToString:@"教师"]){
        [[ST_NetAPIManager sharedManager]request_modifyTeacherPwd_WithTeaId:stuId pwd:pwd newPwd:newPwd andBlock:^(id data, NSError *error) {
            if([data isEqualToString:@"成功"]){
                [MHGlobalFunction showHUD:@"教师密码修改成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [MHGlobalFunction showHUD:@"修改失败"];
            }
        }];
    }
    
}
@end
