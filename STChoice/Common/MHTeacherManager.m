//
//  MHTeacherManager.m
//  STChoice
//
//  Created by AloesLu on 16/5/3.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHTeacherManager.h"
#import "MHTeacher.h"
#import "MHChoose.h"

#define kUserDefaults_teacher_teaId @"teacher_teaId"
#define kUserDefaults_teacher_teaName @"teacher_teaName"
#define kUserDefaults_teacher_sex @"teacher_sex"
#define kUserDefaults_teacher_avatar @"teacher_avatar"
#define kUserDefaults_teacher_teaTitle @"teacher_teaTitle"
#define kUserDefaults_teacher_direction @"teacher_direction"
#define kUserDefaults_teacher_contact @"teacher_contact"
#define kUserDefaults_teacher_email @"teacher_email"
#define kUserDefaults_teacher_teaPaper @"teacher_teaPaper"
#define kUserDefaults_teacher_teaProject @"teacher_teaProject"
#define kUserDefaults_teacher_honour @"teacher_honour"
#define kUserDefaults_teacher_stuRequire @"teacher_stuRequire"

#define kUserDefaults_teacher_choose_arry @"teacher_choose_arry"

#define kUserDefaults_hasSelectStudent @"hasSelectStudent"

@implementation MHTeacherManager
+ (instancetype)sharedManager{
    static MHTeacherManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (void)setTeacherData:(MHTeacher *)teacher{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if(teacher.teaId){
        [defaults setObject:teacher.teaId forKey:kUserDefaults_teacher_teaId];
    }
    if(teacher.teaName){
        [defaults setObject:teacher.teaName forKey:kUserDefaults_teacher_teaName];
    }
    if(teacher.sex){
        [defaults setObject:teacher.sex forKey:kUserDefaults_teacher_sex];
    }
    if(teacher.avatar){
        [defaults setObject:teacher.avatar forKey:kUserDefaults_teacher_avatar];
    }
    if(teacher.teaTitle){
        [defaults setObject:teacher.teaTitle forKey:kUserDefaults_teacher_teaTitle];
    }
    if(teacher.direction){
        [defaults setObject:teacher.direction forKey:kUserDefaults_teacher_direction];
    }
    if(teacher.contact){
        [defaults setObject:teacher.contact forKey:kUserDefaults_teacher_contact];
    }
    if(teacher.email){
        [defaults setObject:teacher.email forKey:kUserDefaults_teacher_email];
    }
    if(teacher.teaPaper){
        [defaults setObject:teacher.teaPaper forKey:kUserDefaults_teacher_teaPaper];
    }
    if(teacher.teaProject){
        [defaults setObject:teacher.teaProject forKey:kUserDefaults_teacher_teaProject];
    }
    if(teacher.honour){
        [defaults setObject:teacher.honour forKey:kUserDefaults_teacher_honour];
    }
    if(teacher.stuRequire){
        [defaults setObject:teacher.stuRequire forKey:kUserDefaults_teacher_stuRequire];
    }
    if(teacher.QQ){
        [defaults setObject:teacher.QQ forKey:@"teacher_QQ"];
    }
    if(teacher.school){
        [defaults setObject:teacher.school forKey:@"teacher_school"];
    }
    if(teacher.remarks){
        [defaults setObject:teacher.remarks forKey:@"teacher_remarks"];
    }
    [defaults synchronize];
}
- (MHTeacher *)getTeacherData{
    MHTeacher *teacher=[[MHTeacher alloc]init];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    teacher.teaId=[defaults objectForKey:kUserDefaults_teacher_teaId];
    teacher.teaName=[defaults objectForKey:kUserDefaults_teacher_teaName];
    teacher.sex=[defaults objectForKey:kUserDefaults_teacher_sex];
    teacher.avatar=[defaults objectForKey:kUserDefaults_teacher_avatar];
    teacher.teaTitle=[defaults objectForKey:kUserDefaults_teacher_teaTitle];
    teacher.direction=[defaults objectForKey:kUserDefaults_teacher_direction];
    teacher.contact=[defaults objectForKey:kUserDefaults_teacher_contact];
    teacher.email=[defaults objectForKey:kUserDefaults_teacher_email];
    teacher.teaPaper=[defaults objectForKey:kUserDefaults_teacher_teaPaper];
    teacher.teaProject=[defaults objectForKey:kUserDefaults_teacher_teaProject];
    teacher.honour=[defaults objectForKey:kUserDefaults_teacher_honour];
    teacher.stuRequire=[defaults objectForKey:kUserDefaults_teacher_stuRequire];
    teacher.QQ=[defaults objectForKey:@"teacher_QQ"];
    teacher.school=[defaults objectForKey:@"teacher_school"];
    teacher.remarks=[defaults objectForKey:@"teacher_remarks"];
    return teacher;
}

- (void)setkUserDefaults_teacher_choose_arry:(NSMutableArray *)teacher_choose_arry{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:1];
    for(MHChoose * choose in teacher_choose_arry){
        NSDictionary *dict=@{@"stuId":choose.stuId,@"stuName":choose.stuName,@"major":choose.major};
        [arry addObject:dict];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arry];
    [defaults setObject:data forKey:kUserDefaults_teacher_choose_arry];
    [defaults synchronize];
}

- (void)addStudentWish:(MHChoose *)choose{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kUserDefaults_teacher_choose_arry];
    NSMutableArray *teacher_choose_arry = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(teacher_choose_arry==nil){
        teacher_choose_arry=[NSMutableArray arrayWithCapacity:1];
    }
    NSDictionary *dictChoose=@{@"stuId":choose.stuId,@"stuName":choose.stuName,@"major":choose.major};
    BOOL flag=YES;
    for(NSDictionary * dict in teacher_choose_arry){
        if([[dict objectForKey:@"stuId"] isEqualToString:choose.stuId]){
            flag=NO;
        }
    }
    if(flag){
        [teacher_choose_arry addObject:dictChoose];
    }
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:teacher_choose_arry];
    [defaults setObject:data1 forKey:kUserDefaults_teacher_choose_arry];
    [defaults synchronize];
}

- (NSMutableArray *)getkUserDefaults_teacher_choose_arry{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kUserDefaults_teacher_choose_arry];
    NSMutableArray *teacher_choose_arry = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *dict in teacher_choose_arry){
        MHChoose *choose=[MHChoose chooseWithDict:dict];
        [arry addObject:choose];
    }
    return arry;
}

- (void)setkUserDefaults_addhasSelectStudent:(NSString *)stuId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:kUserDefaults_hasSelectStudent]) {
        [defaults setObject:[NSMutableArray array] forKey:kUserDefaults_hasSelectStudent];
    }
    NSMutableArray *mutableArrayCopy = [[defaults objectForKey:kUserDefaults_hasSelectStudent] mutableCopy];
    if (![mutableArrayCopy containsObject:stuId]) {
        [mutableArrayCopy addObject:stuId];
    }
    if (mutableArrayCopy.count >100) {
        [mutableArrayCopy removeObjectAtIndex:0];
    }
    [defaults setObject:mutableArrayCopy forKey:kUserDefaults_hasSelectStudent];
    [defaults synchronize];
    
}
- (BOOL)getkUserDefaultsAndjudgeSelectStuId:(NSString *)stuId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *Arr = [defaults objectForKey:kUserDefaults_hasSelectStudent];
    
    for (NSString *saveStuId in Arr) {
        if ([stuId isEqualToString:saveStuId]) {
            return YES;
            
        }
    }
    return NO;
}
@end
