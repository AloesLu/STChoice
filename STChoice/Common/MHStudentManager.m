//
//  MHStudentManager.m
//  STChoice
//
//  Created by AloesLu on 16/5/3.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHStudentManager.h"
#import "MHStudent.h"
#import "MHWish.h"

#define kUserDefaults_student_stuId @"student_stuId"
#define kUserDefaults_student_stuName @"student_stuName"
#define kUserDefaults_student_sex @"student_sex"
#define kUserDefaults_student_avatar @"student_avatar"
#define kUserDefaults_student_clazz @"student_clazz"
#define kUserDefaults_student_major @"student_major"
#define kUserDefaults_student_contact @"student_contact"
#define kUserDefaults_student_email @"student_email"
#define kUserDefaults_student_rank @"student_rank"
#define kUserDefaults_student_honour @"student_honour"
#define kUserDefaults_student_interst @"student_interst"
#define kUserDefaults_student_works @"student_works"
#define kUserDefaults_student_experience @"student_experience"

#define kUserDefaults_student_wish_arry @"student_wish_arry"

#define kUserDefaults_isSubmitWish @"isSubmitWish"

#define kUserDefaults_hasSelectTeacher @"hasSelectTeacher"

@implementation MHStudentManager
+ (instancetype)sharedManager{
    static MHStudentManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (void)setStudentData:(MHStudent *)student{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if(student.stuId){
        [defaults setObject:student.stuId forKey:kUserDefaults_student_stuId];
    }
    if(student.stuName){
        [defaults setObject:student.stuName forKey:kUserDefaults_student_stuName];
    }
    if(student.sex){
        [defaults setObject:student.sex forKey:kUserDefaults_student_sex];
    }
    if(student.avatar){
        [defaults setObject:student.avatar forKey:kUserDefaults_student_avatar];
    }
    if(student.clazz){
        [defaults setObject:student.clazz forKey:kUserDefaults_student_clazz];
    }
    if(student.major){
        [defaults setObject:student.major forKey:kUserDefaults_student_major];
    }
    if(student.contact){
        [defaults setObject:student.contact forKey:kUserDefaults_student_contact];
    }
    if(student.email){
        [defaults setObject:student.email forKey:kUserDefaults_student_email];
    }
    if(student.rank){
        [defaults setObject:student.rank forKey:kUserDefaults_student_rank];
    }
    if(student.honour){
        [defaults setObject:student.honour forKey:kUserDefaults_student_honour];
    }
    if(student.interst){
        [defaults setObject:student.interst forKey:kUserDefaults_student_interst];
    }
    if(student.works){
        [defaults setObject:student.works forKey:kUserDefaults_student_works];
    }
    if(student.experience){
        [defaults setObject:student.experience forKey:kUserDefaults_student_experience];
    }
    
    if(student.QQ){
        [defaults setObject:student.QQ forKey:@"student_QQ"];
    }
    if(student.grade){
        [defaults setObject:student.grade forKey:@"student_grade"];
    }
    if(student.remarks){
        [defaults setObject:student.remarks forKey:@"student_remarks"];
    }
    [defaults synchronize];
}
- (MHStudent *)getStudentData{
    MHStudent *student=[[MHStudent alloc]init];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    student.stuId=[defaults objectForKey:kUserDefaults_student_stuId];
    student.stuName=[defaults objectForKey:kUserDefaults_student_stuName];
    student.sex=[defaults objectForKey:kUserDefaults_student_sex];
    student.avatar=[defaults objectForKey:kUserDefaults_student_avatar];
    student.clazz=[defaults objectForKey:kUserDefaults_student_clazz];
    student.major=[defaults objectForKey:kUserDefaults_student_major];
    student.contact=[defaults objectForKey:kUserDefaults_student_contact];
    student.email=[defaults objectForKey:kUserDefaults_student_email];
    student.rank=[defaults objectForKey:kUserDefaults_student_rank];
    student.honour=[defaults objectForKey:kUserDefaults_student_honour];
    student.interst=[defaults objectForKey:kUserDefaults_student_interst];
    student.works=[defaults objectForKey:kUserDefaults_student_works];
    student.experience=[defaults objectForKey:kUserDefaults_student_experience];
    student.QQ=[defaults objectForKey:@"student_QQ"];
    student.grade=[defaults objectForKey:@"student_grade"];
    student.remarks=[defaults objectForKey:@"student_remarks"];
    return student;
}

- (void)setkUserDefaults_student_wish_arry:(NSMutableArray *)student_wish_arry{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:1];
    for(MHWish * wish in student_wish_arry){
        NSDictionary *dict=@{@"teaId":wish.teaId,@"teaName":wish.teaName,@"teaTitle":wish.teaTitle};
        [arry addObject:dict];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arry];
    [defaults setObject:data forKey:kUserDefaults_student_wish_arry];
    [defaults synchronize];
}

- (void)addStudentWish:(MHWish *)wish{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kUserDefaults_student_wish_arry];
    NSMutableArray *student_wish_arry = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(student_wish_arry==nil){
        student_wish_arry=[NSMutableArray arrayWithCapacity:1];
    }
    NSDictionary *dictWish=@{@"teaId":wish.teaId,@"teaName":wish.teaName,@"teaTitle":wish.teaTitle};
    BOOL flag=YES;
    for(NSDictionary * dict in student_wish_arry){
        if([[dict objectForKey:@"teaId"] isEqualToString:wish.teaId]){
            flag=NO;
        }
    }
    if(flag){
        [student_wish_arry addObject:dictWish];
    }
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:student_wish_arry];
    [defaults setObject:data1 forKey:kUserDefaults_student_wish_arry];
    [defaults synchronize];
}

- (NSMutableArray *)getkUserDefaults_student_wish_arry{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kUserDefaults_student_wish_arry];
    NSMutableArray *student_wish_arry = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *dict in student_wish_arry){
        MHWish *wish=[MHWish wishWithDict:dict];
        [arry addObject:wish];
    }
    return arry;
}

- (void)setkUserDefaults_isSubmitWish:(NSNumber *)isSubmitWish{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:isSubmitWish forKey:kUserDefaults_isSubmitWish];
    [defaults synchronize];
}
- (NSNumber *)getkUserDefaults_isSubmitWish{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kUserDefaults_isSubmitWish];
}

- (void)setkUserDefaults_addhasSelectTeacher:(NSString *)teaId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:kUserDefaults_hasSelectTeacher]) {
        [defaults setObject:[NSMutableArray array] forKey:kUserDefaults_hasSelectTeacher];
    }
    NSMutableArray *mutableArrayCopy = [[defaults objectForKey:kUserDefaults_hasSelectTeacher] mutableCopy];
    if (![mutableArrayCopy containsObject:teaId]) {
        [mutableArrayCopy addObject:teaId];
    }
    if (mutableArrayCopy.count >100) {
        [mutableArrayCopy removeObjectAtIndex:0];
    }
    [defaults setObject:mutableArrayCopy forKey:kUserDefaults_hasSelectTeacher];
    [defaults synchronize];
    
}
- (BOOL)getkUserDefaultsAndjudgeSelectTeaId:(NSString *)teaId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *Arr = [defaults objectForKey:kUserDefaults_hasSelectTeacher];
    
    for (NSString *saveTeaId in Arr) {
        if ([teaId isEqualToString:saveTeaId]) {
            return YES;
            
        }
    }
    return NO;
}

@end
