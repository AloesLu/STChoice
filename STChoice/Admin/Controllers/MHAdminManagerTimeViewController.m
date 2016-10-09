//
//  MHAdminManagerTimeViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/26.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHAdminManagerTimeViewController.h"
#import "MHAdminEditTimeViewController.h"
#import "MHAddUserViewController.h"
#import "MHTime.h"

@interface MHAdminManagerTimeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *studentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherTime1Label;
@property (weak, nonatomic) IBOutlet UILabel *teacherTime2Label;
@property (weak, nonatomic) IBOutlet UILabel *teacherTime3Label;
@property (weak, nonatomic) IBOutlet UILabel *adminTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *studentTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *teacher1TimeButton;
@property (weak, nonatomic) IBOutlet UIButton *teacher2TimeButton;
@property (weak, nonatomic) IBOutlet UIButton *teacher3TimeButton;
@property (weak, nonatomic) IBOutlet UIButton *adminTimeButton;

@property(nonatomic,strong)NSMutableArray *timeArry;

@end

@implementation MHAdminManagerTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"时间控制";
    UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"编辑" rect:CGRectMake(0, 0, 50, 40) size:15];
    [button setTitleColor:kLeadColor forState:UIControlStateNormal];
    [button setTitleColor:nil forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(editTime) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton *leftbutton=[MHGlobalFunction getIconFontBarButtonItem:@"退出" rect:CGRectMake(0, 0, 50, 40) size:15];
    [leftbutton setTitleColor:kLeadColor forState:UIControlStateNormal];
    [leftbutton setTitleColor:nil forState:UIControlStateHighlighted];
    [leftbutton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getTimeArry];
}

- (void)logout{
    [appMHDelegate logoutApp:1];
}

- (void)editTime{
    if([self judgeIsAllEnd]!=10){
        [MHGlobalFunction showHUD:@"双向选择进行中，无法编辑时间"];
        return ;
    }
    MHAdminEditTimeViewController *aetVC=[[MHAdminEditTimeViewController alloc]init];
    aetVC.timeArry=self.timeArry;
    MHBaseNavigationController *nav=[[MHBaseNavigationController alloc]initWithRootViewController:aetVC];
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}

- (IBAction)studentTimeAction:(id)sender {
    if([self judgeIsAllEnd]!=0&&[self judgeIsAllEnd]!=10){
        [MHGlobalFunction showHUD:@"请首先结束正在进行中的阶段"];
        return ;
    }
    MHTime *time=[_timeArry objectAtIndex:0];
    if([time.timeStatus intValue]==0){
        time.timeStatus=[NSNumber numberWithInt:1];
    }else{
        time.timeStatus=[NSNumber numberWithInt:0];
    }
    [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:time andBlock:^(id data, NSError *error) {
        if([data isEqualToString:@"成功"]){
            [self setDataToFace:self.studentTimeLabel button:self.studentTimeButton time:time];
            [self.timeArry replaceObjectAtIndex:0 withObject:time];
        }
    }];
}
- (IBAction)teacher1TimeAction:(id)sender {
    if([self judgeIsAllEnd]!=1&&[self judgeIsAllEnd]!=10){
        [MHGlobalFunction showHUD:@"请首先结束正在进行中的阶段"];
        return ;
    }
    MHTime *time=[_timeArry objectAtIndex:1];
    if([time.timeStatus intValue]==0){
        time.timeStatus=[NSNumber numberWithInt:1];
    }else{
        time.timeStatus=[NSNumber numberWithInt:0];
    }
    [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:time andBlock:^(id data, NSError *error) {
        if([data isEqualToString:@"成功"]){
            [self setDataToFace:self.teacherTime1Label button:self.teacher1TimeButton time:time];
            [self.timeArry replaceObjectAtIndex:1 withObject:time];
        }
    }];
}
- (IBAction)teacher2TimeAction:(id)sender {
    if([self judgeIsAllEnd]!=2&&[self judgeIsAllEnd]!=10){
        [MHGlobalFunction showHUD:@"请首先结束正在进行中的阶段"];
        return ;
    }
    MHTime *time=[_timeArry objectAtIndex:2];
    if([time.timeStatus intValue]==0){
        time.timeStatus=[NSNumber numberWithInt:1];
    }else{
        time.timeStatus=[NSNumber numberWithInt:0];
    }
    [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:time andBlock:^(id data, NSError *error) {
        if([data isEqualToString:@"成功"]){
            [self setDataToFace:self.teacherTime2Label button:self.teacher2TimeButton time:time];
            [self.timeArry replaceObjectAtIndex:2 withObject:time];
        }
    }];
}
- (IBAction)teacher3TimeAction:(id)sender {
    if([self judgeIsAllEnd]!=3&&[self judgeIsAllEnd]!=10){
        [MHGlobalFunction showHUD:@"请首先结束正在进行中的阶段"];
        return ;
    }
    MHTime *time=[_timeArry objectAtIndex:3];
    if([time.timeStatus intValue]==0){
        time.timeStatus=[NSNumber numberWithInt:1];
    }else{
        time.timeStatus=[NSNumber numberWithInt:0];
    }
    [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:time andBlock:^(id data, NSError *error) {
        if([data isEqualToString:@"成功"]){
            [self setDataToFace:self.teacherTime3Label button:self.teacher3TimeButton time:time];
            [self.timeArry replaceObjectAtIndex:3 withObject:time];
        }
    }];
}
- (IBAction)adminTimeAction:(id)sender {
    if([self judgeIsAllEnd]!=4&&[self judgeIsAllEnd]!=10){
        [MHGlobalFunction showHUD:@"请首先结束正在进行中的阶段"];
        return ;
    }
    MHTime *time=[_timeArry objectAtIndex:4];
    if([time.timeStatus intValue]==0){
        time.timeStatus=[NSNumber numberWithInt:1];
    }else{
        time.timeStatus=[NSNumber numberWithInt:0];
    }
    [[ST_NetAPIManager sharedManager]request_saveTime_WithTime:time andBlock:^(id data, NSError *error) {
        if([data isEqualToString:@"成功"]){
            [self setDataToFace:self.adminTimeLabel button:self.adminTimeButton time:time];
            [self.timeArry replaceObjectAtIndex:4 withObject:time];
        }
    }];
}

- (void)getTimeArry{
    [[ST_NetAPIManager sharedManager]request_timeList_WithTimeStatus:nil andBlock:^(id data, NSError *error) {
        if(data){
            _timeArry=data;
            if(self.timeArry.count>0){
                [self setDataToFace:self.studentTimeLabel button:self.studentTimeButton time:[_timeArry objectAtIndex:0]];
            }
            if(self.timeArry.count>1){
                [self setDataToFace:self.teacherTime1Label button:self.teacher1TimeButton time:[_timeArry objectAtIndex:1]];
            }
            if(self.timeArry.count>2){
                [self setDataToFace:self.teacherTime2Label button:self.teacher2TimeButton time:[_timeArry objectAtIndex:2]];
            }
            if(self.timeArry.count>3){
                [self setDataToFace:self.teacherTime3Label button:self.teacher3TimeButton time:[_timeArry objectAtIndex:3]];
            }
            if(self.timeArry.count>4){
                [self setDataToFace:self.adminTimeLabel button:self.adminTimeButton time:[_timeArry objectAtIndex:4]];
            }
        }
    }];
}

- (void)setDataToFace:(UILabel *)label button:(UIButton *)button time:(MHTime *)time{
    label.text=[NSString stringWithFormat:@"%@--%@",time.startTime,time.endTime];
    label.hidden=NO;
    button.hidden=NO;
    if([time.timeStatus intValue]==0){
        [button setTitle:@"开始" forState:UIControlStateNormal];
        [button setBackgroundColor:kMainColorIcon];
    }else{
        [button setTitle:@"结束" forState:UIControlStateNormal];
        [button setBackgroundColor:kDescribeColor];
    }
}

- (int)judgeIsAllEnd{
    for(int i=0;i<self.timeArry.count;i++){
        MHTime *time=[self.timeArry objectAtIndex:i];
        if([time.timeStatus intValue]==1){
            return i;
        }
    }
    return 10;
}
@end
