//
//  MHSubmitChooseViewController.m
//  STChoice
//
//  Created by AloesLu on 16/5/9.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHSubmitChooseViewController.h"
#import "MHChoose.h"

@interface MHSubmitChooseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *chooseArry;
@end

@implementation MHSubmitChooseViewController
static NSString *submitChooseCell=@"submit_choose_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交筛选";
    self.chooseArry=[[MHTeacherManager sharedManager] getkUserDefaults_teacher_choose_arry];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHSubmitChooseCell" bundle:nil] forCellReuseIdentifier:submitChooseCell];
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"确认" rect:CGRectMake(0, 0, 50, 40) size:15];
    [button setTitleColor:kLeadColor forState:UIControlStateNormal];
    [button setTitleColor:nil forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(submitChoose) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"MHTipView" owner:self options:nil];
    if (nib > 0) {
        UIView *headerTVC = [nib objectAtIndex:0];
        //每个广告横幅右侧的关闭按钮
        UILabel *tipLabel=(UILabel *)[headerTVC viewWithTag:717];
        tipLabel.text=@"现在是第一轮志愿筛选阶段，您还可以选择8位学生";
        self.tableView.tableHeaderView = headerTVC;
    }
}

- (void)submitChoose{
    for(int i=0;i<self.chooseArry.count&&i<3;i++){
        MHChoose *choose=[self.chooseArry objectAtIndex:i];
        MHTeacher *teacher=[[MHTeacherManager sharedManager]getTeacherData];
        choose.teaId=teacher.teaId;
        choose.stuStatus=[NSNumber numberWithInt:0];
        choose.teaStatus=[NSNumber numberWithInt:0];
        choose.wishNum=[NSNumber numberWithInt:[[[MHAdminManager sharedManager]getTimeType]intValue]-1];
        [[ST_NetAPIManager sharedManager]request_saveChoose_WithChoose:choose andBlock:^(id data, NSError *error) {
            if([data isEqualToString:@"成功"]){
                [[MHTeacherManager sharedManager]setkUserDefaults_addhasSelectStudent:choose.stuId];
                [MHGlobalFunction showHUD:@"提交成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chooseArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:submitChooseCell forIndexPath:indexPath];
    MHChoose *choose=[self.chooseArry objectAtIndex:indexPath.row];
    UILabel *wishNumLabel=[cell viewWithTag:1];
    UILabel *nameLabel=[cell viewWithTag:2];
    UILabel *teaTitleLabel=[cell viewWithTag:3];
    CustomButton *button=[cell viewWithTag:4];
    wishNumLabel.text=[NSString stringWithFormat:@"选择%ld",indexPath.row+1];
    nameLabel.text=choose.stuName;
    teaTitleLabel.text=choose.major;
    [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=kMHRedColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"删除" forState:UIControlStateNormal];
    button.someId=[NSString stringWithFormat:@"%ld",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)delete:(CustomButton *)sender{
    NSInteger index=[sender.someId integerValue];
    [self.chooseArry removeObjectAtIndex:index];
    [self.tableView reloadData];
}
@end
