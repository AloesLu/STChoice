//
//  MHModifyPersonSignViewController.m
//  vomoho
//
//  Created by 刘华军 on 15/12/1.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import "MHModifyPersonSignViewController.h"
#import "MHUser.h"
#import "UIPlaceHolderTextView.h"
#import "CustomButton.h"
#import "MHStudent.h"

@interface MHModifyPersonSignViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIPlaceHolderTextView *editText;
@property (strong,nonatomic) UILabel *characterCountLabel;

@property (strong,nonatomic) NSString *typeName;
@property (strong, nonatomic)UITapGestureRecognizer *tapView;
@end

@implementation MHModifyPersonSignViewController
static NSString *modifyTips2 = @"modify_tips2";

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
    [self.tableView registerNib:[UINib nibWithNibName:@"MHModifyTips2" bundle:nil] forCellReuseIdentifier:modifyTips2];
    
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//

/**
 *  完成按钮事件
 */
-(void)finishButtonAction{
    if (_editText.text != nil && (![_editText.text isEqualToString:@""])) {
        
        if(self.isTeacher){
            MHTeacher *teacher=[[MHTeacherManager sharedManager]getTeacherData];
            if([_typeName isEqualToString:@"论文情况"]){
                teacher.teaPaper=_editText.text;
            }else if([_typeName isEqualToString:@"项目情况"]){
                teacher.teaProject=_editText.text;
            }else if([_typeName isEqualToString:@"荣誉情况"]){
                teacher.honour=_editText.text;
            }else if([_typeName isEqualToString:@"学生要求"]){
                teacher.stuRequire=_editText.text;
            }
            [[MHTeacherManager sharedManager]setTeacherData:teacher];
            
        }else{
            MHStudent *student=[[MHStudentManager sharedManager]getStudentData];
            if([_typeName isEqualToString:@"荣誉情况"]){
                student.honour=_editText.text;
            }else if([_typeName isEqualToString:@"兴趣爱好"]){
                student.interst=_editText.text;
            }else if([_typeName isEqualToString:@"作品"]){
                student.works=_editText.text;
            }else if([_typeName isEqualToString:@"过往经历"]){
                student.experience=_editText.text;
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
    cell = [tableView dequeueReusableCellWithIdentifier:modifyTips2 forIndexPath:indexPat];
    
    if (indexPat.row == 0) {
        _editText = (UIPlaceHolderTextView *)[cell viewWithTag:3];
        _characterCountLabel=(UILabel *)[cell viewWithTag:4];
        _editText.text=_content;
        _characterCountLabel.text=[NSString stringWithFormat:@"%ld/200",_editText.text.length];
        _editText.placeholder=[NSString stringWithFormat:@"填写%@",_typeName];
        _editText.delegate=self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)
                                                    name:@"UITextViewTextDidChangeNotification"
                                                  object:_editText];
        [_editText becomeFirstResponder];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 200;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewEditChanged:(NSNotification *)obj{
    UIPlaceHolderTextView *textView = (UIPlaceHolderTextView *)obj.object;
    if(textView.text.length>=200){
        _characterCountLabel.text=@"200/200";
        NSString *showText=@"个性签名不能超过200字哦";
        int maxLenth=200;
        [MHGlobalFunction judgeNumTextView:textView maxLenght:maxLenth showText:showText];
    }else{
        _characterCountLabel.text=[NSString stringWithFormat:@"%ld/200",textView.text.length];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
