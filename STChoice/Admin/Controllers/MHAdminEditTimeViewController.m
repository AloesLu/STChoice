//
//  MHAdminEditTimeViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/26.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHAdminEditTimeViewController.h"
#import "UIPlaceHolderTextView.h"
#import "MHDatePickerView.h"
#import "UITapImageView.h"
#import "MHTime.h"

@interface MHAdminEditTimeViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property(nonatomic,strong)NSString * tempTime;
@property(nonatomic,strong)MHTime * timeModel1;
@property(nonatomic,strong)MHTime * timeModel2;
@property(nonatomic,strong)MHTime * timeModel3;
@property(nonatomic,strong)MHTime * timeModel4;
@property(nonatomic,strong)MHTime * timeModel5;
@end

@implementation MHAdminEditTimeViewController

static NSString *editTimeCell=@"edit_time_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCellArray];
    [self initNavigationItem];
    if(self.timeArry.count>0){
        self.timeModel1=[self.timeArry objectAtIndex:0];
    }else{
        self.timeModel1=[[MHTime alloc]init];
        self.timeModel1.timeType=[NSNumber numberWithInt:1];
        self.timeModel1.timeStatus=[NSNumber numberWithInt:0];
    }
    if(self.timeArry.count>1){
        self.timeModel2=[self.timeArry objectAtIndex:1];
    }else{
        self.timeModel2=[[MHTime alloc]init];
        self.timeModel2.timeType=[NSNumber numberWithInt:2];
        self.timeModel2.timeStatus=[NSNumber numberWithInt:0];
    }
    if(self.timeArry.count>2){
        self.timeModel3=[self.timeArry objectAtIndex:2];
    }else{
        self.timeModel3=[[MHTime alloc]init];
        self.timeModel3.timeType=[NSNumber numberWithInt:3];
        self.timeModel3.timeStatus=[NSNumber numberWithInt:0];
    }
    if(self.timeArry.count>3){
        self.timeModel4=[self.timeArry objectAtIndex:3];
    }else{
        self.timeModel4=[[MHTime alloc]init];
        self.timeModel4.timeType=[NSNumber numberWithInt:4];
        self.timeModel4.timeStatus=[NSNumber numberWithInt:0];
    }
    if(self.timeArry.count>4){
        self.timeModel5=[self.timeArry objectAtIndex:4];
    }else{
        self.timeModel5=[[MHTime alloc]init];
        self.timeModel5.timeType=[NSNumber numberWithInt:5];
        self.timeModel5.timeStatus=[NSNumber numberWithInt:0];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark - Params Init

- (void)initNavigationItem{
    self.title=@"填写时间段";
    UIButton *button=[MHGlobalFunction getIconNavBarButton:@"\U0000e6db"];
    [button setTitleColor:kWeakTextColor forState:UIControlStateNormal];
    [button setTitleColor:kWeakTextColorPress forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

/**
 *  读取cell
 */
- (void)initCellArray {
    [self.tableView registerNib:[UINib nibWithNibName:@"STEditTimeCell" bundle:nil] forCellReuseIdentifier:editTimeCell];
}

#pragma mark - Action Respond
/**
 *  关闭本页
 */
- (void)closePage{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  跳转下一页
 *
 *  @param sender sender
 */
- (IBAction)nextStepAction:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否保存" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(self.timeModel1.startTime&&self.timeModel1.endTime&&self.timeModel2.startTime&&self.timeModel2.endTime&&self.timeModel3.startTime&&self.timeModel3.endTime&&self.timeModel4.startTime&&self.timeModel4.endTime&&self.timeModel5.startTime&&self.timeModel5.endTime){
            int __block i=0;
            __weak typeof(self) weakself=self;
            [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:self.timeModel1 andBlock:^(id data, NSError *error) {
                i++;
                if(i==5){
                    [weakself closePage];
                    [MHGlobalFunction showHUD:@"保存成功"];
                }
            }];
            [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:self.timeModel2 andBlock:^(id data, NSError *error) {
                i++;
                if(i==5){
                    [weakself closePage];
                    [MHGlobalFunction showHUD:@"保存成功"];
                }
            }];
            [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:self.timeModel3 andBlock:^(id data, NSError *error) {
                i++;
                if(i==5){
                    [weakself closePage];
                    [MHGlobalFunction showHUD:@"保存成功"];
                }
            }];
            [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:self.timeModel4 andBlock:^(id data, NSError *error) {
                i++;
                if(i==5){
                    [weakself closePage];
                    [MHGlobalFunction showHUD:@"保存成功"];
                }
            }];
            [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:self.timeModel5 andBlock:^(id data, NSError *error) {
                i++;
                if(i==5){
                    [weakself closePage];
                    [MHGlobalFunction showHUD:@"保存成功"];
                }
            }];
        }else{
            [MHGlobalFunction showHUD:@"请填写完整每一个时间"];
        }
    }]];
    [self presentViewController:alertController animated:YES completion:NULL];
}


- (void)alterSetStartTimeView:(MHTime *)timeModel{
    [self.view endEditing:YES];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *nowdate = [NSDate date];
    NSString *date = [dateFormatter stringFromDate:nowdate];
    MHDatePickerView *datePickerView=[[MHDatePickerView alloc]initWithNowDate:date];
    __weak typeof(datePickerView) weakDatePickerView=datePickerView;
    datePickerView.returnSelectTimeBlock=^(NSString *time){
        if(timeModel.endTime&&[NSDate compareOneDate:time otherDate:timeModel.endTime]){
            
        }else{
            timeModel.startTime=time;
            [self.tableView reloadData];
            [weakDatePickerView cancelOrMaskViewClick];
        }
    };
}
- (void)alterSetEndTimeView:(MHTime *)timeModel{
    [self.view endEditing:YES];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *nowdate = [NSDate date];
    NSString *date = [dateFormatter stringFromDate:nowdate];
    MHDatePickerView *datePickerView=[[MHDatePickerView alloc]initWithNowDate:date];
    __weak typeof(datePickerView) weakDatePickerView=datePickerView;
    datePickerView.returnSelectTimeBlock=^(NSString *time){
        if(timeModel.startTime&&[NSDate compareOneDate:timeModel.startTime otherDate:time]){
        }else{
            timeModel.endTime=time;
            [self.tableView reloadData];
            [weakDatePickerView cancelOrMaskViewClick];
        }
    };
}

#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:editTimeCell forIndexPath:indexPath];
    UILabel *label=(UILabel *)[cell viewWithTag:1];
    UILabel *timeLabel=(UILabel *)[cell viewWithTag:2];
    UITapImageView *clickImage=(UITapImageView *)[cell viewWithTag:717];
    MHTime *timeModel=nil;
    if(indexPath.row==0){
        timeModel=self.timeModel1;
        label.text=@"学生志愿开始";
    }else if(indexPath.row==1){
        timeModel=self.timeModel1;
        label.text=@"学生志愿结束";
    }else if(indexPath.row==2){
        timeModel=self.timeModel2;
        label.text=@"教师一轮开始";
    }else if(indexPath.row==3){
        timeModel=self.timeModel2;
        label.text=@"教师一轮结束";
    }else if(indexPath.row==4){
        timeModel=self.timeModel3;
        label.text=@"教师二轮开始";
    }else if(indexPath.row==5){
        timeModel=self.timeModel3;
        label.text=@"教师二轮结束";
    }else if(indexPath.row==6){
        timeModel=self.timeModel4;
        label.text=@"教师三轮开始";
    }else if(indexPath.row==7){
        timeModel=self.timeModel4;
        label.text=@"教师三轮结束";
    }else if(indexPath.row==8){
        timeModel=self.timeModel5;
        label.text=@"随机分配开始";
    }else if(indexPath.row==9){
        timeModel=self.timeModel5;
        label.text=@"随机分配结束";
    }
    if (indexPath.row%2 == 0) {
        [clickImage setImageWithUrl:nil placeholderImage:nil tapBlock:^(id obj) {
            [self alterSetStartTimeView:timeModel];
        }];
        timeLabel.text=timeModel.startTime;
    }else{
        [clickImage setImageWithUrl:nil placeholderImage:nil tapBlock:^(id obj) {
            [self alterSetEndTimeView:timeModel];
        }];
        timeLabel.text=timeModel.endTime;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
