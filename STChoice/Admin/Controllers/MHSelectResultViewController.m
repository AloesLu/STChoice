//
//  MHSelectResultViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/26.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHSelectResultViewController.h"
#import "JSDropDownMenu.h"
#import "MHChoose.h"
#import "MHAddUserViewController.h"

@interface MHSelectResultViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate>{
    
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    NSNumber *_teaStatus;
    NSNumber *_stuStatus;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *chooseArry;
@end

@implementation MHSelectResultViewController
static NSString *selectResultCell=@"select_result_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"结果查看";
    
//    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐"];
//    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    
//    _data1 = [NSMutableArray arrayWithObjects:@{@"title":@"美食", @"data":food}, @{@"title":@"旅游", @"data":travel}, nil];
    _data1 = [NSMutableArray arrayWithObjects:@"教师", @"已确认", @"未确认",nil];
    _data2 = [NSMutableArray arrayWithObjects:@"学生", @"已确认", @"未确认", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"专业", @"软件工程", @"计算机", @"信息管理", @"电子商务", @"信息c", nil];
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"STSelectResultCell" bundle:nil] forCellReuseIdentifier:selectResultCell];
    self.tableView.contentInset=UIEdgeInsetsMake(45, 0, 0, 0);
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self getChooseArry];
    
    UIButton *button=[MHGlobalFunction getIconFontBarButtonItem:@"增加" rect:CGRectMake(0, 0, 50, 40) size:15];
    [button setTitleColor:kLeadColor forState:UIControlStateNormal];
    [button setTitleColor:nil forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(addUser) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)addUser{
    MHAddUserViewController *aetVC=[[MHAddUserViewController alloc]init];
    MHBaseNavigationController *nav=[[MHBaseNavigationController alloc]initWithRootViewController:aetVC];
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chooseArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:selectResultCell forIndexPath:indexPath];
    UILabel *teaName=[cell viewWithTag:1];
    UILabel *stuName=[cell viewWithTag:2];
    UILabel *teaStatus=[cell viewWithTag:3];
    UILabel *stuStatus=[cell viewWithTag:4];
    CustomButton *teaPhone=[cell viewWithTag:5];
    CustomButton *stuPhone=[cell viewWithTag:6];
    MHChoose *choose=[_chooseArry objectAtIndex:indexPath.row];
    teaName.text=choose.teacher.teaName;
    stuName.text=choose.student.stuName;
    if([choose.teaStatus intValue]==1){
        teaStatus.text=@"已确认";
        teaStatus.textColor=kMainColorIcon;
    }else{
        teaStatus.text=@"未确认";
        teaStatus.textColor=kTitleColor;
    }
    if([choose.stuStatus intValue]==1){
        stuStatus.text=@"已确认";
        stuStatus.textColor=kMainColorIcon;
    }else{
        stuStatus.text=@"未确认";
        stuStatus.textColor=kTitleColor;
    }
    [MHGlobalFunction setIconImageButton:@"\U0000e6ae" size:24 btn:teaPhone];
    [MHGlobalFunction setIconImageButton:@"\U0000e6ae" size:24 btn:stuPhone];
    if(choose.teacher.contact&&![choose.teacher.contact isEqualToString:@""]){
        [teaPhone setTitleColor:kAssistantColor forState:UIControlStateNormal];
        [teaPhone setTitleColor:kAssistantColorPress forState:UIControlStateHighlighted];
        [teaPhone addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [teaPhone setTitleColor:kSeparatorColor forState:UIControlStateNormal];
    }
    if(choose.student.contact&&![choose.student.contact isEqualToString:@""]){
        [stuPhone setTitleColor:kAssistantColor forState:UIControlStateNormal];
        [stuPhone setTitleColor:kAssistantColorPress forState:UIControlStateHighlighted];
        [stuPhone addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [stuPhone setTitleColor:kSeparatorColor forState:UIControlStateNormal];
    }
    teaPhone.someId=choose.teacher.contact;
    stuPhone.someId=choose.student.contact;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)callPhone:(CustomButton *)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"是否拨打：%@",button.someId] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",button.someId]]];
    }]];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)getChooseArry{
    [[ST_NetAPIManager sharedManager] request_chooseResultList_WithStuStatus:_stuStatus teaStatus:_teaStatus teaId:nil stuId:nil pageNum:nil pageSize:nil andBlock:^(id data, NSError *error) {
        _chooseArry=[NSMutableArray arrayWithCapacity:1];
        if(data){
            _chooseArry=data;
            [self.tableView reloadData];
        }
    }];
}


- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 2;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
//    if (column==0) {
//        return YES;
//    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
//    if (column==0) {
//        return 0.3;
//    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
//        if (leftOrRight==0) {
//            
//            return _data1.count;
//        } else{
//            
//            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
//            return [[menuDic objectForKey:@"data"] count];
//        }
        return _data1.count;
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return _data1[0];//[[_data1[0] objectForKey:@"data"] objectAtIndex:0];
            break;
        case 1: return _data2[0];
            break;
        case 2: return _data3[0];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
//        if (indexPath.leftOrRight==0) {
//            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
//            return [menuDic objectForKey:@"title"];
//        } else{
//            NSInteger leftRow = indexPath.leftRow;
//            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
//            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
//        }
        return _data1[indexPath.row];
    } else if (indexPath.column==1) {
        
        return _data2[indexPath.row];
        
    } else {
        
        return _data3[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
//        if(indexPath.leftOrRight==0){
//            
//            _currentData1Index = indexPath.row;
//            
//            return;
//        }
        if(indexPath.row==0){
           _teaStatus=nil;
        }else if(indexPath.row==1){
            _teaStatus=[NSNumber numberWithInt:1];
        }else{
            _teaStatus=[NSNumber numberWithInt:0];
        }
        
        [[ST_NetAPIManager sharedManager] request_chooseResultList_WithStuStatus:_stuStatus teaStatus:_teaStatus teaId:nil stuId:nil pageNum:nil pageSize:nil andBlock:^(id data, NSError *error) {
            _chooseArry=[NSMutableArray arrayWithCapacity:1];
            if(data){
                _chooseArry=data;
                [self.tableView reloadData];
            }
        }];
        _currentData1Index = indexPath.row;
    } else if(indexPath.column == 1){
        if(indexPath.row==0){
            _stuStatus=nil;
        }else if(indexPath.row==1){
            _stuStatus=[NSNumber numberWithInt:1];
        }else{
            _stuStatus=[NSNumber numberWithInt:0];
        }
        [[ST_NetAPIManager sharedManager] request_chooseResultList_WithStuStatus:_stuStatus teaStatus:_teaStatus teaId:nil stuId:nil pageNum:nil pageSize:nil andBlock:^(id data, NSError *error) {
            _chooseArry=[NSMutableArray arrayWithCapacity:1];
            if(data){
                _chooseArry=data;
                [self.tableView reloadData];
            }
        }];
        _currentData2Index = indexPath.row;
        
    } else{
        NSString *major=nil;
        if(indexPath.row!=0){
            major=_data3[indexPath.row];
        }
        [[ST_NetAPIManager sharedManager] request_chooseStudentResultList_WithClazz:nil major:major pageNum:nil pageSize:nil andBlock:^(id data, NSError *error) {
            _chooseArry=[NSMutableArray arrayWithCapacity:1];
            if(data){
                _chooseArry=data;
                [self.tableView reloadData];
            }
        }];
        _currentData3Index = indexPath.row;
    }
}

@end
