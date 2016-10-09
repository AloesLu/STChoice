//
//  STStudentSureViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/28.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "STStudentSureViewController.h"
#import "MHChoose.h"
#import "MHStudent.h"
#import "MJDIYHeader.h"
#import "STTeacherInfoViewController.h"

@interface STStudentSureViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *chooseArry;
@end

@implementation STStudentSureViewController
static NSString *sureChooseCell=@"sure_choose_cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认关系";
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"MHTipView" owner:self options:nil];
    if (nib > 0) {
        UIView *headerTVC = [nib objectAtIndex:0];
        //每个广告横幅右侧的关闭按钮
        UILabel *tipLabel=(UILabel *)[headerTVC viewWithTag:717];
        tipLabel.text=@"当导师筛选完成，下方会出现选择你的导师，请点击确认导师关系";
        self.tableView.tableHeaderView = headerTVC;
    }
    [self initTableView];
    [self getChooseArry];
}

- (void)initTableView{
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHSureChooseCell" bundle:nil] forCellReuseIdentifier:sureChooseCell];
    self.tableView.header=[MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(getChooseArry)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chooseArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:sureChooseCell forIndexPath:indexPath];
    UITapImageView *avatar=[cell viewWithTag:1];
    UILabel *name=[cell viewWithTag:2];
    CustomButton *select=[cell viewWithTag:5];
    UILabel *email=[cell viewWithTag:9];
    CustomButton *phone=[cell viewWithTag:10];
    MHChoose *choose=[_chooseArry objectAtIndex:indexPath.row];
    [MHGlobalFunction setImageToImageView:avatar url:choose.teacher.avatar];
    name.text=choose.teacher.teaName;
    email.text=[NSString stringWithFormat:@"邮箱：%@",choose.teacher.email];
    [MHGlobalFunction setIconImageButton:@"\U0000e6ae" size:24 btn:phone];
    if(choose.teacher.contact&&![choose.teacher.contact isEqualToString:@""]){
        [phone setTitleColor:kAssistantColor forState:UIControlStateNormal];
        [phone setTitleColor:kAssistantColorPress forState:UIControlStateHighlighted];
        [phone addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [phone setTitleColor:kSeparatorColor forState:UIControlStateNormal];
    }
    phone.someId=choose.teacher.contact;
    if([choose.stuStatus intValue]==1){
        select.backgroundColor=kDescribeColor;
        [select setTitle:@"已确认" forState:UIControlStateNormal];
    }else{
        [select addTarget:self action:@selector(sureTeacher:) forControlEvents:UIControlEventTouchUpInside];
        select.someId=[NSString stringWithFormat:@"%ld",indexPath.row];
        [select setTitle:@"确认" forState:UIControlStateNormal];
        select.backgroundColor=kMainColorIcon;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.chooseArry.count>indexPath.row){
        MHChoose *choose=[_chooseArry objectAtIndex:indexPath.row];
        [[MHTeacherManager sharedManager]setTeacherData:choose.teacher];
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

-(void)sureTeacher:(CustomButton *)sender{
    MHChoose *choose=[_chooseArry objectAtIndex:[sender.someId intValue]];
    choose.stuStatus=[NSNumber numberWithInt:1];
    [[ST_NetAPIManager sharedManager]request_saveChoose_WithChoose:choose andBlock:^(id data, NSError *error) {
        if(data){
            [self.chooseArry replaceObjectAtIndex:[sender.someId intValue] withObject:choose];
            [self.tableView reloadData];
        }
    }];
}

- (void)getChooseArry{
    MHStudent *student=[[MHStudentManager sharedManager]getStudentData];
    [[ST_NetAPIManager sharedManager] request_chooseResultList_WithStuStatus:nil teaStatus:nil teaId:nil stuId:student.stuId pageNum:nil pageSize:nil andBlock:^(id data, NSError *error) {
        [self.tableView.header endRefreshing];
        _chooseArry=[NSMutableArray arrayWithCapacity:1];
        if(data){
            _chooseArry=data;
            [self.tableView reloadData];
        }
    }];
}
@end
