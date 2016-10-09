//
//  STTeacherChooseViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/28.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "STTeacherChooseViewController.h"
#import "MHChoose.h"
#import "MHWish.h"
#import "MJDIYHeader.h"
#import "MHSubmitChooseViewController.h"
#import "STStudentInfoViewController.h"
@interface STTeacherChooseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *studentArry;

@property (weak, nonatomic) IBOutlet UIButton *allstudentButton;
@property (weak, nonatomic) IBOutlet UIButton *wishStudentButton;
@property (strong, nonatomic) NSNumber *studentType;
@end

@implementation STTeacherChooseViewController
static NSString *studentChooseListCell=@"student_choose_list_cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    _studentType=[NSNumber numberWithInt:2];
    
    [self initNavigation];
    
    [self initTableView];
    
    [self initTableHeaderView];
    
    [self getStudentArry];
}

- (void)initNavigation{
    self.title=@"筛选学生";
    UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"提交" rect:CGRectMake(0, 0, 50, 40) size:15];
    [button setTitleColor:kLeadColor forState:UIControlStateNormal];
    [button setTitleColor:nil forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(pushWish) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton *leftbutton=[MHGlobalFunction getIconFontBarButtonItem:@"退出" rect:CGRectMake(0, 0, 50, 40) size:15];
    [leftbutton setTitleColor:kLeadColor forState:UIControlStateNormal];
    [leftbutton setTitleColor:nil forState:UIControlStateHighlighted];
    [leftbutton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
}

- (void)initTableHeaderView{
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"MHTipView" owner:self options:nil];
    if (nib > 0) {
        UIView *headerTVC = [nib objectAtIndex:0];
        //每个广告横幅右侧的关闭按钮
        UILabel *tipLabel=(UILabel *)[headerTVC viewWithTag:717];
        tipLabel.text=[MHGlobalFunction getNowTip];
        self.tableView.tableHeaderView = headerTVC;
    }
}

- (void)initTableView{
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"STStudentChooseListCell" bundle:nil] forCellReuseIdentifier:studentChooseListCell];
    self.tableView.header=[MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(getStudentArry)];
}

- (void)logout{
    [appMHDelegate logoutApp:1];
}

- (void)pushWish{
    if(!([[[MHAdminManager sharedManager]getTimeType]intValue]>1&&[[[MHAdminManager sharedManager]getTimeType]intValue]<5)){
        [MHGlobalFunction showHUD:@"此阶段无法提交筛选"];
        return;
    }
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:1];
    for(MHStudent *student in self.studentArry){
        if(student.isSelect){
            MHChoose *choose=[[MHChoose alloc]init];
            choose.stuId=student.stuId;
            choose.stuName=student.stuName;
            choose.major=student.major;
            [arry addObject:choose];
        }
    }
    [[MHTeacherManager sharedManager]setkUserDefaults_teacher_choose_arry:arry];
    
    MHSubmitChooseViewController *sscVC=[[MHSubmitChooseViewController alloc]init];
    [self.navigationController pushViewController:sscVC animated:YES];
}

- (IBAction)allStudentAction:(id)sender {
     _studentType=[NSNumber numberWithInt:1];
    [self getStudentArry];
    [self.allstudentButton setTitleColor:kTitleColor forState:UIControlStateNormal];
    [self.wishStudentButton setTitleColor:kWeakTextColor forState:UIControlStateNormal];
}
- (IBAction)wishStudentAction:(id)sender {
     _studentType=[NSNumber numberWithInt:2];
    [self getStudentArry];
    [self.allstudentButton setTitleColor:kWeakTextColor forState:UIControlStateNormal];
    [self.wishStudentButton setTitleColor:kTitleColor forState:UIControlStateNormal];
}
#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.studentArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:studentChooseListCell forIndexPath:indexPath];
    UITapImageView *avatar=[cell viewWithTag:1];
    UILabel *name=[cell viewWithTag:2];
    UILabel *sex=[cell viewWithTag:3];
    UILabel *tag=[cell viewWithTag:4];
    CustomButton *select=[cell viewWithTag:5];
    UILabel *major=[cell viewWithTag:6];
    UILabel *clazz=[cell viewWithTag:7];
    UILabel *rank=[cell viewWithTag:8];
    UILabel *email=[cell viewWithTag:9];
    CustomButton *phone=[cell viewWithTag:10];
    
    MHStudent *student=[_studentArry objectAtIndex:indexPath.row];
    [MHGlobalFunction setImageToImageView:avatar url:student.avatar];
    name.text=student.stuName;
    [MHGlobalFunction setGenderAndAgeLabel:sex gender:student.sex];
    major.text=[NSString stringWithFormat:@"专业：%@",student.major];
    clazz.text=[NSString stringWithFormat:@"班级：%@",student.clazz];
    rank.text=[NSString stringWithFormat:@"排名：%@",student.rank];
    email.text=[NSString stringWithFormat:@"邮箱：%@",student.email];
    [MHGlobalFunction setIconImageButton:@"\U0000e6ae" size:24 btn:phone];
    if(student.contact&&![student.contact isEqualToString:@""]){
        [phone setTitleColor:kAssistantColor forState:UIControlStateNormal];
        [phone setTitleColor:kAssistantColorPress forState:UIControlStateHighlighted];
        [phone addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [phone setTitleColor:kSeparatorColor forState:UIControlStateNormal];
    }
    phone.someId=student.contact;
    if([self.studentType intValue]==1){
        select.hidden=YES;
    }else{
        select.hidden=NO;
        if(student.isSelect){
            select.backgroundColor=kDescribeColor;
        }else{
            [select addTarget:self action:@selector(selectStudent:) forControlEvents:UIControlEventTouchUpInside];
            select.someId=[NSString stringWithFormat:@"%ld",indexPath.row];
            select.backgroundColor=kMainColorIcon;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.studentArry.count>indexPath.row){
        MHStudent *student=[_studentArry objectAtIndex:indexPath.row];
        [[MHStudentManager sharedManager]setStudentData:student];
        STStudentInfoViewController *siVC=[[STStudentInfoViewController alloc]init];
        siVC.isSave=YES;
        [self.navigationController pushViewController:siVC animated:YES];
    }
}

- (void)callPhone:(CustomButton *)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"是否拨打：%@",button.someId] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",button.someId]]];
    }]];
    [self presentViewController:alertController animated:YES completion:NULL];
}

-(void)selectStudent:(CustomButton *)sender{
    MHStudent *student=[self.studentArry objectAtIndex:[sender.someId integerValue]];
    if(student.isSelect){
        student.isSelect=NO;
    }else{
        student.isSelect=YES;
    }
    [self.tableView reloadData];
}

- (void)getStudentArry{
    if([_studentType intValue]==1){
        MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
        [MHGlobalFunction showHUD:@"加载中..." andView:self.view andHUD:hud];
        [[ST_NetAPIManager sharedManager] request_studentList_WithMajor:nil clazz:nil pageNum:nil pageSize:nil andBlock:^(id data, NSError *error) {
            [hud show:NO];
            [hud removeFromSuperview];
            [self.tableView.header endRefreshing];
            _studentArry=[NSMutableArray arrayWithCapacity:1];
            if(data){
                _studentArry=data;
                [self.tableView reloadData];
            }
        }];
    }else{
        MHTeacher *teacher=[[MHTeacherManager sharedManager]getTeacherData];
        NSNumber *wishNum=nil;
        if([[[MHAdminManager sharedManager] getTimeType]intValue]==2){
            wishNum=[NSNumber numberWithInt:1];
        }else if([[[MHAdminManager sharedManager] getTimeType]intValue]==3){
            wishNum=[NSNumber numberWithInt:2];
        }else if([[[MHAdminManager sharedManager] getTimeType]intValue]==4){
            wishNum=[NSNumber numberWithInt:3];
        }
        if(wishNum){
            MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
            [MHGlobalFunction showHUD:@"加载中..." andView:self.view andHUD:hud];
            [[ST_NetAPIManager sharedManager] request_stuWishList_WithStuId:nil teaId:teacher.teaId wishNum:wishNum pageNum:nil pageSize:nil andBlock:^(id data, NSError *error) {
                [hud show:NO];
                [hud removeFromSuperview];
                [self.tableView.header endRefreshing];
                _studentArry=[NSMutableArray arrayWithCapacity:1];
                if(data){
                    for(MHWish *wish in data){
                        wish.student.isSelect=[[MHStudentManager sharedManager]getkUserDefaultsAndjudgeSelectTeaId:wish.student.stuId];
                        [_studentArry addObject:wish.student];
                    }
                }
                [self.tableView reloadData];
            }];
        }else{
            [self.tableView.header endRefreshing];
            _studentArry=[NSMutableArray arrayWithCapacity:1];
            [self.tableView reloadData];
        }

    }
    [[ST_NetAPIManager sharedManager]request_timeList_WithTimeStatus:[NSNumber numberWithInt:1] andBlock:^(id data, NSError *error) {
        if(data){
            NSMutableArray *arry=data;
            if(arry.count>0){
                [[MHAdminManager sharedManager]setKNowTimeSection:[data objectAtIndex:0]];
            }else{
                [[MHAdminManager sharedManager]setKNowTimeSection:nil];
            }
            [self initTableHeaderView];
        }
    }];
}

@end
