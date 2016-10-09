//
//  MHAddUserViewController.m
//  STChoice
//
//  Created by AloesLu on 16/5/9.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHAddUserViewController.h"

@interface MHAddUserViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phonePic;
@property (weak, nonatomic) IBOutlet UILabel *passPic;
@property (weak, nonatomic) IBOutlet UILabel *namePic;
@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UISwitch *typeSwitch;

@property (strong, nonatomic)UITapGestureRecognizer *tapView;
@end

@implementation MHAddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新增用户";
    self.phonePic.text=@"\U0000e6c3";
    self.passPic.text=@"\U0000e6c1";
    self.namePic.text=@"\U0000e6cb";
    UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"取消" rect:CGRectMake(0, 0, 50, 40) size:15];
    [button setTitleColor:kLeadColor forState:UIControlStateNormal];
    [button setTitleColor:nil forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.tapView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
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
    NSString *name=self.userNameTextField.text;
    NSString *pwd=self.userPwdTextField.text;
    if([self.typeSwitch isOn]){
        if(![[stuId substringToIndex:2] isEqualToString:@"12"]){
            [MHGlobalFunction showHUD:@"学号不符合要求"];
            return;
        }
        [[ST_NetAPIManager sharedManager]request_addStudent_WithStuId:stuId pwd:pwd name:name andBlock:^(id data, NSError *error) {
            if([data isEqualToString:@"成功"]){
                [MHGlobalFunction showHUD:@"添加成功"];
            }
        }];
    }else{
        if(![[stuId substringToIndex:2] isEqualToString:@"20"]){
            [MHGlobalFunction showHUD:@"工号不符合要求"];
            return;
        }
        [[ST_NetAPIManager sharedManager]request_addTeacher_WithTeaId:stuId pwd:pwd name:name andBlock:^(id data, NSError *error) {
            if([data isEqualToString:@"成功"]){
                [MHGlobalFunction showHUD:@"添加成功"];
            }
        }];
    }
}

@end
