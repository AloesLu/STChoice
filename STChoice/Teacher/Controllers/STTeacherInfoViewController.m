//
//  STTeacherInfoViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/28.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "STTeacherInfoViewController.h"
#import "MHModifyNickViewController.h"
#import "MHModifyPersonSignViewController.h"

@interface STTeacherInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MHTeacher *teacher;
@end

@implementation STTeacherInfoViewController

static NSString *personMaterialCell1=@"person_material_cell1";
static NSString *personMaterialCell2=@"person_material_cell2";
static NSString *personMaterialCell3=@"person_material_cell3";
static NSString *personMaterialCell4=@"person_material_cell4";

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_isSave){
        self.title=@"我";
    }else{
        self.title=@"个人信息";
    }
    self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHPersonMaterialCell1" bundle:nil] forCellReuseIdentifier:personMaterialCell1];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHPersonMaterialCell2" bundle:nil] forCellReuseIdentifier:personMaterialCell2];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHPersonMaterialCell3" bundle:nil] forCellReuseIdentifier:personMaterialCell3];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHPersonMaterialCell4" bundle:nil] forCellReuseIdentifier:personMaterialCell4];
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    if(!_isSave){
        UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"保存" rect:CGRectMake(0, 0, 50, 40) size:15];
        [button setTitleColor:kLeadColor forState:UIControlStateNormal];
        [button setTitleColor:nil forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    }
}

- (void)saveInfo{
    [[ST_NetAPIManager sharedManager]request_saveOrUpdateTeacher_WithTeacher:[[MHTeacherManager sharedManager]getTeacherData] andBlock:^(id data, NSError *error) {
        if(data){
            [[MHTeacherManager sharedManager]setTeacherData:data];
            [self.tableView reloadData];
            [MHGlobalFunction showHUD:@"个人信息保存成功"];
        }
    }];
}

#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=nil;
    if(indexPath.row==0){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell1 forIndexPath:indexPath];
        UITapImageView *avatar=[cell viewWithTag:1];
        UILabel *nameLabel=[cell viewWithTag:2];
        UILabel *rankLabel=[cell viewWithTag:3];
        rankLabel.hidden=YES;
        [MHGlobalFunction setImageToImageView:avatar url:self.teacher.avatar];
        nameLabel.text=self.teacher.teaName;
    }else if(indexPath.row==1){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell2 forIndexPath:indexPath];
        UILabel *namelabel=[cell viewWithTag:1];
        UILabel *contentLabel=[cell viewWithTag:2];
        namelabel.text=@"职称";
        contentLabel.text=self.teacher.teaTitle;
    }else if(indexPath.row==2){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell2 forIndexPath:indexPath];
        UILabel *namelabel=[cell viewWithTag:1];
        UILabel *contentLabel=[cell viewWithTag:2];
        namelabel.text=@"研究方向";
        contentLabel.text=self.teacher.direction;
    }else if(indexPath.row==3){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell2 forIndexPath:indexPath];
        UILabel *namelabel=[cell viewWithTag:1];
        UILabel *contentLabel=[cell viewWithTag:2];
        namelabel.text=@"电话";
        contentLabel.text=self.teacher.contact;
    }else if(indexPath.row==4){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell2 forIndexPath:indexPath];
        UILabel *namelabel=[cell viewWithTag:1];
        UILabel *contentLabel=[cell viewWithTag:2];
        namelabel.text=@"邮箱";
        contentLabel.text=self.teacher.email;
    }else if(indexPath.row==5){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell3 forIndexPath:indexPath];
        UILabel *namelabel=[cell viewWithTag:1];
        UILabel *contentLabel=[cell viewWithTag:2];
        namelabel.text=@"论文情况";
        contentLabel.text=self.teacher.teaPaper;
    }else if(indexPath.row==6){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell3 forIndexPath:indexPath];
        UILabel *namelabel=[cell viewWithTag:1];
        UILabel *contentLabel=[cell viewWithTag:2];
        namelabel.text=@"项目情况";
        contentLabel.text=self.teacher.teaProject;
    }else if(indexPath.row==7){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell3 forIndexPath:indexPath];
        UILabel *namelabel=[cell viewWithTag:1];
        UILabel *contentLabel=[cell viewWithTag:2];
        namelabel.text=@"荣誉情况";
        contentLabel.text=self.teacher.honour;
    }else if(indexPath.row==8){
        cell=[tableView dequeueReusableCellWithIdentifier:personMaterialCell3 forIndexPath:indexPath];
        UILabel *namelabel=[cell viewWithTag:1];
        UILabel *contentLabel=[cell viewWithTag:2];
        namelabel.text=@"学生要求";
        contentLabel.text=self.teacher.stuRequire;
    }
    UILabel *label=[cell viewWithTag:2];
    if(label.text==nil||[label.text isEqualToString:@""]){
        label.text=@"未填写";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 100;
    }else if(indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==4){
        return 44;
    }else if(indexPath.row==5){
        CGSize size=[self.teacher.teaPaper getSizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kScreen_Width-105, MAXFLOAT)];
        CGFloat height=size.height>14?size.height:14;
        return height+30;
    }else if(indexPath.row==6){
        CGSize size=[self.teacher.teaProject getSizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kScreen_Width-105, MAXFLOAT)];
        CGFloat height=size.height>14?size.height:14;
        return height+30;
    }else if(indexPath.row==7){
        CGSize size=[self.teacher.honour getSizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kScreen_Width-105, MAXFLOAT)];
        CGFloat height=size.height>14?size.height:14;
        return height+30;
    }else if(indexPath.row==8){
        CGSize size=[self.teacher.stuRequire getSizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kScreen_Width-105, MAXFLOAT)];
        CGFloat height=size.height>14?size.height:14;
        return height+30;
    }
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_isSave){
        return;
    }
    if(indexPath.row==0){
        
    }else if(indexPath.row==1){
        MHModifyNickViewController *mnVC=[[MHModifyNickViewController alloc]initWithName:@"职称"];
        mnVC.isTeacher=YES;
        mnVC.refreshEidtInfoViewBlock=^(){
            self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
            [self.tableView reloadData];
        };
        mnVC.content=self.teacher.teaTitle;
        [self.navigationController pushViewController:mnVC animated:YES];
    }else if(indexPath.row==2){
        MHModifyNickViewController *mnVC=[[MHModifyNickViewController alloc]initWithName:@"研究方向"];
        mnVC.isTeacher=YES;
        mnVC.refreshEidtInfoViewBlock=^(){
            self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
            [self.tableView reloadData];
        };
        mnVC.content=self.teacher.direction;
        [self.navigationController pushViewController:mnVC animated:YES];
    }else if(indexPath.row==3){
        MHModifyNickViewController *mnVC=[[MHModifyNickViewController alloc]initWithName:@"电话"];
        mnVC.isTeacher=YES;
        mnVC.refreshEidtInfoViewBlock=^(){
            self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
            [self.tableView reloadData];
        };
        mnVC.content=self.teacher.contact;
        [self.navigationController pushViewController:mnVC animated:YES];
    }else if(indexPath.row==4){
        MHModifyNickViewController *mnVC=[[MHModifyNickViewController alloc]initWithName:@"邮箱"];
        mnVC.isTeacher=YES;
        mnVC.refreshEidtInfoViewBlock=^(){
            self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
            [self.tableView reloadData];
        };
        mnVC.content=self.teacher.email;
        [self.navigationController pushViewController:mnVC animated:YES];
    }else if(indexPath.row==5){
        MHModifyPersonSignViewController *mnVC=[[MHModifyPersonSignViewController alloc]initWithName:@"论文情况"];
        mnVC.isTeacher=YES;
        mnVC.refreshEidtInfoViewBlock=^(){
            self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
            [self.tableView reloadData];
        };
        mnVC.content=self.teacher.teaPaper;
        [self.navigationController pushViewController:mnVC animated:YES];
    }else if(indexPath.row==6){
        MHModifyPersonSignViewController *mnVC=[[MHModifyPersonSignViewController alloc]initWithName:@"项目情况"];
        mnVC.isTeacher=YES;
        mnVC.refreshEidtInfoViewBlock=^(){
            self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
            [self.tableView reloadData];
        };
        mnVC.content=self.teacher.teaProject;
        [self.navigationController pushViewController:mnVC animated:YES];
    }else if(indexPath.row==7){
        MHModifyPersonSignViewController *mnVC=[[MHModifyPersonSignViewController alloc]initWithName:@"荣誉情况"];
        mnVC.isTeacher=YES;
        mnVC.refreshEidtInfoViewBlock=^(){
            self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
            [self.tableView reloadData];
        };
        mnVC.content=self.teacher.honour;
        [self.navigationController pushViewController:mnVC animated:YES];
    }else if(indexPath.row==8){
        MHModifyPersonSignViewController *mnVC=[[MHModifyPersonSignViewController alloc]initWithName:@"学生要求"];
        mnVC.isTeacher=YES;
        mnVC.refreshEidtInfoViewBlock=^(){
            self.teacher=[[MHTeacherManager sharedManager]getTeacherData];
            [self.tableView reloadData];
        };
        mnVC.content=self.teacher.stuRequire;
        [self.navigationController pushViewController:mnVC animated:YES];
    }
}
@end
