//
//  MHStudnetSubmitChooseViewController.m
//  STChoice
//
//  Created by AloesLu on 16/5/5.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHStudnetSubmitChooseViewController.h"
#import "MHWish.h"
#import "MHStudent.h"
#import "UIPlaceHolderTextView.h"

@interface MHStudnetSubmitChooseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *wishArry;
@property (strong, nonatomic)UIPlaceHolderTextView *theme;
@end

@implementation MHStudnetSubmitChooseViewController
static NSString *submitChooseCell=@"submit_choose_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交志愿";
    self.wishArry=[[MHStudentManager sharedManager] getkUserDefaults_student_wish_arry];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHSubmitChooseCell" bundle:nil] forCellReuseIdentifier:submitChooseCell];
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"确认" rect:CGRectMake(0, 0, 50, 40) size:15];
    [button setTitleColor:kLeadColor forState:UIControlStateNormal];
    [button setTitleColor:nil forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(submitWish) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"MHAddActivityHeaderView" owner:self options:nil];
    if (nib > 0) {
        UIView *headerTVC = [nib objectAtIndex:0];
        //每个广告横幅右侧的关闭按钮
        UILabel *tipLabel=(UILabel *)[headerTVC viewWithTag:717];
        UIButton *btn=(UIButton *)[headerTVC viewWithTag:2];
        tipLabel.text=@"点击上移来更换志愿的顺序，您还可以在下方输入你想对导师说的话！留言对象为所有选择的老师";
        [MHGlobalFunction setIconImageButton:@"\U0000e628" size:20 btn:btn];
        [btn setTitleColor:kAssistantColor forState:UIControlStateNormal];
        self.tableView.tableHeaderView = headerTVC;
        
        _theme  = (UIPlaceHolderTextView *)[headerTVC viewWithTag:718];
        _theme.tag = 20001;
        _theme.placeholder=@"请输入留言";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:@"UITextViewTextDidChangeNotification" object:_theme];
    }
}

- (void)submitWish{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"提交只保存前三个志愿，并且不能更改，是否提交" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for(int i=0;i<self.wishArry.count&&i<3;i++){
            MHWish *wish=[self.wishArry objectAtIndex:i];
            MHStudent *student=[[MHStudentManager sharedManager]getStudentData];
            wish.stuId=student.stuId;
            wish.wishNum=[NSNumber numberWithInt:i+1];
            wish.content=_theme.text;
            __weak typeof(self )weakSelf=self;
            [[ST_NetAPIManager sharedManager]request_saveWish_WithWish:wish andBlock:^(id data, NSError *error) {
                if(i==weakSelf.wishArry.count-1){
                    [MHGlobalFunction showHUD:@"提交成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    [[MHStudentManager sharedManager]setkUserDefaults_isSubmitWish:[NSNumber numberWithInt:1]];
                }
                [[MHStudentManager sharedManager]setkUserDefaults_addhasSelectTeacher:wish.teaId];
            }];
        }
    }]];
    [self presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wishArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:submitChooseCell forIndexPath:indexPath];
    MHWish *wish=[self.wishArry objectAtIndex:indexPath.row];
    UILabel *wishNumLabel=[cell viewWithTag:1];
    UILabel *nameLabel=[cell viewWithTag:2];
    UILabel *teaTitleLabel=[cell viewWithTag:3];
    CustomButton *button=[cell viewWithTag:4];
    if(indexPath.row==0){
        wishNumLabel.text=@"第一志愿";
    }else if(indexPath.row==1){
        wishNumLabel.text=@"第二志愿";
    }else if(indexPath.row==2){
        wishNumLabel.text=@"第三志愿";
    }else{
        wishNumLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    }
    nameLabel.text=wish.teaName;
    teaTitleLabel.text=wish.teaTitle;
    [button addTarget:self action:@selector(clickMove:) forControlEvents:UIControlEventTouchUpInside];
    button.someId=[NSString stringWithFormat:@"%ld",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)clickMove:(CustomButton *)sender{
    NSInteger index=[sender.someId integerValue];
    if(index>0){
        [self.wishArry exchangeObjectAtIndex:index withObjectAtIndex:index-1];
    }
    [self.tableView reloadData];
}

// 输入的活动地址字数提醒
-(void)textViewEditChanged:(NSNotification *)obj{
    UIPlaceHolderTextView *textView = (UIPlaceHolderTextView *)obj.object;
    if (textView.tag == 20001) {
        if(textView.text.length>=100){
            NSString * showText = @"活动地址不能超过100字哦";
            int maxLenth = 100;
            [MHGlobalFunction judgeNumTextView:textView maxLenght:maxLenth showText:showText];
        }
    }
}

// 消毁通知中心
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
