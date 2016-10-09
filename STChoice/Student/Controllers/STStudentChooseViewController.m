//
//  STStudentChooseViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/26.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "STStudentChooseViewController.h"
#import "MHTeacher.h"
#import "MHWish.h"
#import "MHStudnetSubmitChooseViewController.h"
#import "MJDIYHeader.h"
#import "STTeacherInfoViewController.h"

@interface STStudentChooseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *teacherArry;

@end

@implementation STStudentChooseViewController
static NSString *teacherChooseListCell=@"teacher_choose_list_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    [self initTableHeaderView];
    [self getTeacherArry];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigation];
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

- (void)initNavigation{
    self.title=@"志愿选择";
    UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"提交" rect:CGRectMake(0, 0, 50, 40) size:15];
    if([[[MHStudentManager sharedManager]getkUserDefaults_isSubmitWish]intValue]==1){
        [button setTitleColor:kDescribeColor forState:UIControlStateNormal];
        [button setTitleColor:nil forState:UIControlStateHighlighted];
    }else{
        [button setTitleColor:kLeadColor forState:UIControlStateNormal];
        [button setTitleColor:nil forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(pushWish) forControlEvents:UIControlEventTouchUpInside];
    }
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton *leftbutton=[MHGlobalFunction getIconFontBarButtonItem:@"退出" rect:CGRectMake(0, 0, 50, 40) size:15];
    [leftbutton setTitleColor:kLeadColor forState:UIControlStateNormal];
    [leftbutton setTitleColor:nil forState:UIControlStateHighlighted];
    [leftbutton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
}

- (void)initTableView{
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"STTeacherChooseListCell" bundle:nil] forCellReuseIdentifier:teacherChooseListCell];
    self.tableView.header=[MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(getTeacherArry)];
}

- (void)logout{
    [appMHDelegate logoutApp:1];
}

- (void)pushWish{
    if([[[MHAdminManager sharedManager]getTimeType]intValue]!=1){
        [MHGlobalFunction showHUD:@"此阶段无法提交志愿"];
        return;
    }
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:1];
    for(MHTeacher *teacher in self.teacherArry){
        if(teacher.isSelect){
            MHWish *wish=[[MHWish alloc]init];
            wish.teaId=teacher.teaId;
            wish.teaName=teacher.teaName;
            wish.teaTitle=teacher.teaTitle;
            [arry addObject:wish];
        }
    }
    [[MHStudentManager sharedManager]setkUserDefaults_student_wish_arry:arry];
    
    MHStudnetSubmitChooseViewController *sscVC=[[MHStudnetSubmitChooseViewController alloc]init];
    [self.navigationController pushViewController:sscVC animated:YES];
}

#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teacherArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:teacherChooseListCell forIndexPath:indexPath];
    UITapImageView *avatar=[cell viewWithTag:1];
    UILabel *name=[cell viewWithTag:2];
    UILabel *sex=[cell viewWithTag:3];
    UILabel *tag=[cell viewWithTag:4];
    CustomButton *select=[cell viewWithTag:5];
    UILabel *teaTitle=[cell viewWithTag:6];
    UILabel *direction=[cell viewWithTag:7];
    UILabel *email=[cell viewWithTag:8];
    CustomButton *phone=[cell viewWithTag:9];
    MHTeacher *teacher=[_teacherArry objectAtIndex:indexPath.row];
    [MHGlobalFunction setImageToImageView:avatar url:teacher.avatar];
    name.text=teacher.teaName;
    [MHGlobalFunction setGenderAndAgeLabel:sex gender:teacher.sex];
    teaTitle.text=[NSString stringWithFormat:@"职称：%@",teacher.teaTitle];
    direction.text=[NSString stringWithFormat:@"研究方向：%@",teacher.direction];
    email.text=[NSString stringWithFormat:@"邮箱：%@",teacher.email];
    [MHGlobalFunction setIconImageButton:@"\U0000e6ae" size:24 btn:phone];
    if(teacher.contact&&![teacher.contact isEqualToString:@""]){
        [phone setTitleColor:kAssistantColor forState:UIControlStateNormal];
        [phone setTitleColor:kAssistantColorPress forState:UIControlStateHighlighted];
        [phone addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [phone setTitleColor:kSeparatorColor forState:UIControlStateNormal];
    }
    phone.someId=teacher.contact;
    if(teacher.isSelect){
        select.backgroundColor=kDescribeColor;
    }else{
        [select addTarget:self action:@selector(selectTeacher:) forControlEvents:UIControlEventTouchUpInside];
        select.someId=[NSString stringWithFormat:@"%ld",indexPath.row];
        select.backgroundColor=kMainColorIcon;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.teacherArry.count>indexPath.row){
        MHTeacher *teacher=[_teacherArry objectAtIndex:indexPath.row];
        [[MHTeacherManager sharedManager]setTeacherData:teacher];
        STTeacherInfoViewController *siVC=[[STTeacherInfoViewController alloc]init];
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

-(void)selectTeacher:(CustomButton *)sender{
    MHTeacher *teacher=[self.teacherArry objectAtIndex:[sender.someId integerValue]];
    if(teacher.isSelect){
        teacher.isSelect=NO;
    }else{
        teacher.isSelect=YES;
    }
    [self.tableView reloadData];
}

- (void)getTeacherArry{
    [[ST_NetAPIManager sharedManager] request_teacherList_WithTeaTitle:nil direction:nil pageNum:nil pageSize:nil andBlock:^(id data, NSError *error) {
        [self.tableView.header endRefreshing];
        _teacherArry=[NSMutableArray arrayWithCapacity:1];
        if(data){
            _teacherArry=data;
            [self.tableView reloadData];
        }
    }];
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
    }];}
@end
