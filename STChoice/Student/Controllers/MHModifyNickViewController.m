//
//  MHModifyNickViewController.m
//  vomoho
//
//  Created by 刘华军 on 15/12/1.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import "MHModifyNickViewController.h"
#import "MHStudent.h"
#import "CustomButton.h"

@interface MHModifyNickViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UITextField *editText;
@property (strong,nonatomic) NSString *myText;
@property (strong,nonatomic) UILabel *characterCountLabel;

@property (strong,nonatomic) NSString *typeName;
@property (strong, nonatomic)UITapGestureRecognizer *tapView;
@end

@implementation MHModifyNickViewController

static NSString *modifyTips = @"modify_tips";

-(instancetype)initWithName:(NSString *)name{
    self=[super init];
    if(self){
        _typeName=name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationItem];
    [self initTableView];
    
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

/**
 *  初始化导航栏
 */
-(void)initNavigationItem{
    self.title = _typeName;
    //设置导航栏右边按钮
    CustomButton *rightbutton=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    [MHGlobalFunction setOperateButton:rightbutton title:@"确定" state:1];
    [rightbutton addTarget:self action:@selector(finishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
}
-(void)initTableView{
    _tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"MHModifyTips" bundle:nil] forCellReuseIdentifier:modifyTips];
    
}

/**
 *  完成按钮事件
 */
-(void)finishButtonAction{
    if (_editText.text != nil && (![_editText.text isEqualToString:@""])) {
        if(self.isTeacher){
            MHTeacher *teacher=[[MHTeacherManager sharedManager]getTeacherData];
            if([_typeName isEqualToString:@"职称"]){
                teacher.teaTitle=_editText.text;
            }else if([_typeName isEqualToString:@"研究方向"]){
                teacher.direction=_editText.text;
            }else if([_typeName isEqualToString:@"电话"]){
                teacher.contact=_editText.text;
            }else if([_typeName isEqualToString:@"邮箱"]){
                teacher.email=_editText.text;
            }
            [[MHTeacherManager sharedManager]setTeacherData:teacher];
            
        }else{
            if([_typeName isEqualToString:@"rank"]){
                NSScanner* scan = [NSScanner scannerWithString:_editText.text];
                int val;
                if(!([scan scanInt:&val] && [scan isAtEnd])){
                    [MHGlobalFunction showHUD:@"请输入正确的数字"];
                    return;
                }
                if(_editText.text.length>2){
                    [MHGlobalFunction showHUD:@"数字不能超过两位"];
                    return;
                }
            }
            MHStudent *student=[[MHStudentManager sharedManager]getStudentData];
            if([_typeName isEqualToString:@"班级"]){
                student.clazz=_editText.text;
            }else if([_typeName isEqualToString:@"专业"]){
                student.major=_editText.text;
            }else if([_typeName isEqualToString:@"电话"]){
                student.contact=_editText.text;
            }else if([_typeName isEqualToString:@"邮箱"]){
                student.email=_editText.text;
            }else if([_typeName isEqualToString:@"rank"]){
                student.rank=[[NSNumberFormatter alloc]numberFromString:_editText.text];
            }
            [[MHStudentManager sharedManager]setStudentData:student];
        }
        if(_refreshEidtInfoViewBlock){
            _refreshEidtInfoViewBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

#pragma mark UITableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    UITableViewCell *cell=nil;
    cell = [tableView dequeueReusableCellWithIdentifier:modifyTips forIndexPath:indexPat];
    
    if (indexPat.row == 0) {
        _editText = (UITextField *)[cell viewWithTag:3];
        _characterCountLabel=(UILabel *)[cell viewWithTag:4];
        _editText.placeholder=[NSString stringWithFormat:@"请输入%@",_typeName];
        _editText.text=_content;
        _characterCountLabel.text=[NSString stringWithFormat:@"%ld/20",_editText.text.length];
        _editText.delegate=self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                    name:@"UITextFieldTextDidChangeNotification"
                                                  object:_editText];
        [_editText becomeFirstResponder];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 75;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    if(textField.text.length>=20){
        _characterCountLabel.text=@"20/20";
        NSString *showText=@"昵称长度不能超过20个字哦";
        int maxLenth=20;
        [MHGlobalFunction judgeNumTextField:textField maxLenght:maxLenth showText:showText];
    }else{
        _characterCountLabel.text=[NSString stringWithFormat:@"%ld/20",textField.text.length];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
