//
//  ST_NetAPIManager.m
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "ST_NetAPIManager.h"
#import "CodingNetAPIClient.h"
#import "MHTime.h"
#import "MHStudent.h"
#import "MHTeacher.h"
#import "MHTag.h"
#import "MHWish.h"
#import "MHChoose.h"

#define ktimeList @"time/timeList"
#define ksaveTime @"time/saveTime"

#define kchooseResultList @"choose/chooseResultList"
#define kchooseTeacherResultList @"choose/chooseTeacherResultList"
#define kchooseStudentResultList @"choose/chooseStudentResultList"
#define ksaveChoose @"choose/saveChoose"
#define ksaveFenPeiChoose @"choose/saveFenPeiChoose"

#define kstudentDetail @"student/studentDetail"
#define ksaveStudent @"student/saveStudent"
#define kstudentList @"student/studentList"
#define kaddStudent @"student/addStudent"
#define kstudentLogin @"student/studentLogin"
#define kmodifyStudentPwd @"student/modifyStudentPwd"

#define ksaveWish @"wish/saveWish"
#define kwishResultList @"wish/wishResultList"

#define kteacherDetail @"teacher/teacherDetail"
#define ksaveTeacher @"teacher/saveTeacher"
#define kteacherList @"teacher/teacherList"
#define kaddTeacher @"teacher/addTeacher"
#define kteacherLogin @"teacher/teacherLogin"
#define kteacherFenPeiList @"teacher/teacherFenPeiList"
#define kmodifyTeacherPwd @"teacher/modifyTeacherPwd"
#define kmodifyAdminPwd @"admin/modifyAdminPwd"

#define kadminLogin @"admin/adminLogin"

@implementation ST_NetAPIManager
+ (instancetype)sharedManager {
    static ST_NetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (void)request_timeList_WithTimeStatus:(NSNumber *)timeStatus andBlock:(void (^)(id, NSError *))block{
//    MHTime *time1=[self getTime];
//    time1.timeType=[NSNumber numberWithInt:1];
//    MHTime *time2=[self getTime];
//    time2.timeType=[NSNumber numberWithInt:2];
//    MHTime *time3=[self getTime];
//    time3.timeType=[NSNumber numberWithInt:3];
//    MHTime *time4=[self getTime];
//    time4.timeType=[NSNumber numberWithInt:4];
//    MHTime *time5=[self getTime];
//    time5.timeType=[NSNumber numberWithInt:5];
//    NSMutableArray *arry=[NSMutableArray arrayWithObjects:time1,time2,time3,time4,time5, nil];
//    block(arry,nil);
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (timeStatus) {
        [dict setObject:timeStatus forKey:@"timeStatus"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:ktimeList withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSMutableArray *dataArry=[NSMutableArray arrayWithCapacity:1];
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSArray *values=[dictData objectForKey:@"values"];
                if(values!=nil&&values.count>0){
                    for (NSDictionary *dict in values) {
                        MHTime *time=[MHTime timeWithDict:dict];
                        [dataArry addObject:time];
                    }
                }
            }else{
            }
            block(dataArry, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_saveTime_WithTime:(MHTime *)time andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (time.timeId) {
        [dict setObject:time.timeId forKey:@"id"];
    }
    if(time.timeStatus){
        [dict setObject:time.timeStatus forKey:@"timeStatus"];
    }
    if(time.timeType){
        [dict setObject:time.timeType forKey:@"timeType"];
    }
    if(time.startTime){
        [dict setObject:[MHGlobalFunction timeIntervalFromString:time.startTime] forKey:@"startTime"];
    }
    if(time.endTime){
        [dict setObject:[MHGlobalFunction timeIntervalFromString:time.endTime] forKey:@"endTime"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:ksaveTime withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSString *info=@"失败";
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                info=@"成功";
            }else{
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_saveChoose_WithChoose:(MHChoose *)choose andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (choose.chooseId) {
        [dict setObject:choose.chooseId forKey:@"id"];
    }
    if(choose.teaId){
        [dict setObject:choose.teaId forKey:@"teaId"];
    }
    if(choose.wishNum){
        [dict setObject:choose.wishNum forKey:@"wishNum"];
    }
    if(choose.stuId){
        [dict setObject:choose.stuId forKey:@"stuId"];
    }
    if(choose.stuStatus){
        [dict setObject:choose.stuStatus forKey:@"stuStatus"];
    }
    if(choose.teaStatus){
        [dict setObject:choose.teaStatus forKey:@"teaStatus"];
    }
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:ksaveChoose withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSString *info=@"失败";
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                info=@"成功";
            }else{
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_chooseResultList_WithStuStatus:(NSNumber *)stuStatus teaStatus:(NSNumber *)teaStatus teaId:(NSString *)teaId stuId:(NSString *)stuId pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id, NSError *))block{
//    MHChoose *choose=[self getChoose];
//    NSMutableArray *arry=[NSMutableArray arrayWithObjects:choose, nil];
//    block(arry,nil);
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (stuStatus) {
        [dict setObject:stuStatus forKey:@"stuStatus"];
    }
    if (teaStatus) {
        [dict setObject:teaStatus forKey:@"teaStatus"];
    }
    if (teaId) {
        [dict setObject:teaId forKey:@"teaId"];
    }
    if (stuId) {
        [dict setObject:stuId forKey:@"stuId"];
    }
    if (pageNum) {
        [dict setObject:pageNum forKey:@"pageNum"];
    }
    if (pageSize) {
        [dict setObject:pageSize forKey:@"pageSize"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kchooseResultList withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSMutableArray *dataArry=[NSMutableArray arrayWithCapacity:1];
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSArray *values=[dictData objectForKey:@"value"];
                if(values!=nil&&values.count>0){
                    for (NSDictionary *dict in values) {
                        MHChoose *choose=[MHChoose chooseWithDict:dict];
                        [dataArry addObject:choose];
                    }
                }
            }else{
            }
            block(dataArry, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_chooseTeacherResultList_WithTeaTitle:(NSString *)teaTitle pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id, NSError *))block{
    //    MHChoose *choose=[self getChoose];
    //    NSMutableArray *arry=[NSMutableArray arrayWithObjects:choose, nil];
    //    block(arry,nil);
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (teaTitle) {
        [dict setObject:teaTitle forKey:@"teaTitle"];
    }
    if (pageNum) {
        [dict setObject:pageNum forKey:@"pageNum"];
    }
    if (pageSize) {
        [dict setObject:pageSize forKey:@"pageSize"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kchooseTeacherResultList withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSMutableArray *dataArry=[NSMutableArray arrayWithCapacity:1];
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSArray *values=[dictData objectForKey:@"value"];
                if(values!=nil&&values.count>0){
                    for (NSDictionary *dict in values) {
                        MHChoose *choose=[MHChoose chooseWithDict:dict];
                        [dataArry addObject:choose];
                    }
                }
            }else{
            }
            block(dataArry, nil);
        }else{
            block(nil, error);
        }
    }];
}
- (void)request_chooseStudentResultList_WithClazz:(NSString *)clazz major:(NSString *)major pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id, NSError *))block{
    //    MHChoose *choose=[self getChoose];
    //    NSMutableArray *arry=[NSMutableArray arrayWithObjects:choose, nil];
    //    block(arry,nil);
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (clazz) {
        [dict setObject:clazz forKey:@"clazz"];
    }
    if (major) {
        [dict setObject:major forKey:@"major"];
    }
    if (pageNum) {
        [dict setObject:pageNum forKey:@"pageNum"];
    }
    if (pageSize) {
        [dict setObject:pageSize forKey:@"pageSize"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kchooseStudentResultList withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSMutableArray *dataArry=[NSMutableArray arrayWithCapacity:1];
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSArray *values=[dictData objectForKey:@"value"];
                if(values!=nil&&values.count>0){
                    for (NSDictionary *dict in values) {
                        MHChoose *choose=[MHChoose chooseWithDict:dict];
                        [dataArry addObject:choose];
                    }
                }
            }else{
            }
            block(dataArry, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_saveFenPeiChoose_WithTeaId:(NSString *)teaId selectNum:(NSNumber *)selectNum andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (teaId) {
        [dict setObject:teaId forKey:@"teaId"];
    }
    if (selectNum) {
        [dict setObject:selectNum forKey:@"selectNum"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:ksaveFenPeiChoose withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSNumber *success=nil;
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                success=[dictData objectForKey:@"value"];
            }else{
            }
            block(success, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_getStudentDetail_WithStuId:(NSString *)stuId andBlock:(void (^)(id, NSError *))block{
//    MHStudent *student=[self getStudent];
//    block(student,nil);
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (stuId) {
        [dict setObject:stuId forKey:@"id"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kstudentDetail withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            MHStudent *student=nil;
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSDictionary *values=[dictData objectForKey:@"value"];
                student=[MHStudent studentWithDict:values];
            }else{
            }
            block(student, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_saveOrUpdateStudent_WithStudent:(MHStudent *)student andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (student.stuId) {
        [dict setObject:student.stuId forKey:@"id"];
    }
    if(student.avatar){
        [dict setObject:student.avatar forKey:@"avatar"];
    }
    if(student.stuName){
        [dict setObject:student.stuName forKey:@"name"];
    }
    if(student.clazz){
        [dict setObject:student.clazz forKey:@"clazz"];
    }
    if(student.major){
        [dict setObject:student.major forKey:@"major"];
    }
    if (student.contact) {
        [dict setObject:student.contact forKey:@"contact"];
    }
    if(student.email){
        [dict setObject:student.email forKey:@"email"];
    }
    if(student.honour){
        [dict setObject:student.honour forKey:@"honour"];
    }
    if(student.interst){
        [dict setObject:student.interst forKey:@"interst"];
    }
    if(student.works){
        [dict setObject:student.works forKey:@"works"];
    }
    if(student.experience){
        [dict setObject:student.experience forKey:@"experience"];
    }
    if(student.sex){
        [dict setObject:student.sex forKey:@"sex"];
    }
    if(student.rank){
        [dict setObject:student.rank forKey:@"rank"];
    }
    if(student.grade){
        [dict setObject:student.grade forKey:@"grade"];
    }
    if(student.QQ){
        [dict setObject:student.QQ forKey:@"QQ"];
    }
    if(student.remarks){
        [dict setObject:student.remarks forKey:@"remarks"];
    }
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:ksaveStudent withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            MHStudent *student=nil;
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSDictionary *values=[dictData objectForKey:@"value"];
                student=[MHStudent studentWithDict:values];
            }else{
            }
            block(student, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_studentList_WithMajor:(NSString *)major clazz:(NSString *)clazz pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id, NSError *))block{
//    MHStudent *student=[self getStudent];
//    NSMutableArray *arry=[NSMutableArray arrayWithObjects:student, nil];
//    block(arry,nil);
//    return;
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (major) {
        [dict setObject:major forKey:@"major"];
    }
    if(clazz){
        [dict setObject:clazz forKey:@"clazz"];
    }
    if (pageNum) {
        [dict setObject:pageNum forKey:@"pageNum"];
    }
    if (pageSize) {
        [dict setObject:pageSize forKey:@"pageSize"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kstudentList withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSMutableArray *dataArry=[NSMutableArray arrayWithCapacity:1];
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSArray *values=[dictData objectForKey:@"value"];
                if(values!=nil&&values.count>0){
                    for (NSDictionary *dict in values) {
                        MHStudent *student=[MHStudent studentWithDict:dict];
                        [dataArry addObject:student];
                    }
                }
            }else{
            }
            block(dataArry, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_addStudent_WithStuId:(NSString *)stuId pwd:(NSString *)pwd name:(NSString *)name andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (stuId) {
        [dict setObject:stuId forKey:@"id"];
    }
    if(pwd){
        [dict setObject:pwd forKey:@"pwd"];
    }
    if(name){
        [dict setObject:name forKey:@"name"];
    }
    [dict setObject:[self getRandomAvatar] forKey:@"avatar"];
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kaddStudent withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSString *info=@"失败";
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                info=@"成功";
            }else if([status intValue]==111){
                [MHGlobalFunction showHUD:@"学号已经存在"];
            }else{
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_studentLogin_WithStuId:(NSString *)stuId pwd:(NSString *)pwd andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (stuId) {
        [dict setObject:stuId forKey:@"id"];
    }
    if(pwd){
        [dict setObject:pwd forKey:@"pwd"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kstudentLogin withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            MHStudent *student=nil;
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSDictionary *values=[dictData objectForKey:@"value"];
                student=[MHStudent studentWithDict:values];
            }else{
            }
            block(student, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_modifyStudentPwd_WithStuId:(NSString *)stuId pwd:(NSString *)pwd newPwd:(NSString *)newPwd andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (stuId) {
        [dict setObject:stuId forKey:@"id"];
    }
    if(pwd){
        [dict setObject:pwd forKey:@"pwd"];
    }
    if(newPwd){
        [dict setObject:newPwd forKey:@"newPwd"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kmodifyStudentPwd withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSNumber *status=[dictData objectForKey:@"status"];
            NSString *info=@"失败";
            if([status intValue]==0){
                info=@"成功";
            }else{
                
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_saveWish_WithWish:(MHWish *)wish andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (wish.wishId) {
        [dict setObject:wish.wishId forKey:@"id"];
    }
    if(wish.teaId){
        [dict setObject:wish.teaId forKey:@"teaId"];
    }
    if(wish.wishNum){
        [dict setObject:wish.wishNum forKey:@"wishNum"];
    }
    if(wish.stuId){
        [dict setObject:wish.stuId forKey:@"stuId"];
    }
    if(wish.content){
        [dict setObject:wish.content forKey:@"content"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:ksaveWish withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSString *info=@"失败";
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                info=@"成功";
            }else{
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_stuWishList_WithStuId:(NSString *)stuId teaId:(NSString *)teaId wishNum:(NSNumber *)wishNum pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id, NSError *))block{
//    MHWish *wish=[self getWish];
//    NSMutableArray *arry=[NSMutableArray arrayWithObjects:wish, nil];
//    block(arry,nil);
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (stuId) { 
        [dict setObject:stuId forKey:@"stuId"];
    }
    if (teaId) {
        [dict setObject:teaId forKey:@"teaId"];
    }
    if (wishNum) {
        [dict setObject:wishNum forKey:@"wishNum"];
    }
    if (pageNum) {
        [dict setObject:pageNum forKey:@"pageNum"];
    }
    if (pageSize) {
        [dict setObject:pageSize forKey:@"pageSize"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kwishResultList withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSMutableArray *dataArry=[NSMutableArray arrayWithCapacity:1];
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSArray *values=[dictData objectForKey:@"value"];
                if(values!=nil&&values.count>0){
                    for (NSDictionary *dict in values) {
                        MHWish *wish=[MHWish wishWithDict:dict];
                        [dataArry addObject:wish];
                    }
                }
            }else{
            }
            block(dataArry, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_getTeacherDetail_WithTeaId:(NSString *)teaId andBlock:(void (^)(id, NSError *))block{
//    MHTeacher *teacher=[self getTeacher];
//    block(teacher,nil);
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (teaId) {
        [dict setObject:teaId forKey:@"id"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kteacherDetail withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            MHTeacher *teacher=nil;
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSDictionary *values=[dictData objectForKey:@"value"];
                teacher=[MHTeacher teacherWithDict:values];
            }else{
            }
            block(teacher, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_saveOrUpdateTeacher_WithTeacher:(MHTeacher *)teacher andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (teacher.teaId) {
        [dict setObject:teacher.teaId forKey:@"id"];
    }
    if(teacher.avatar){
        [dict setObject:teacher.avatar forKey:@"avatar"];
    }
    if(teacher.teaName){
        [dict setObject:teacher.teaName forKey:@"name"];
    }
    if(teacher.teaTitle){
        [dict setObject:teacher.teaTitle forKey:@"teaTitle"];
    }
    if(teacher.direction){
        [dict setObject:teacher.direction forKey:@"direction"];
    }
    if (teacher.contact) {
        [dict setObject:teacher.contact forKey:@"contact"];
    }
    if(teacher.email){
        [dict setObject:teacher.email forKey:@"email"];
    }
    if(teacher.honour){
        [dict setObject:teacher.honour forKey:@"honour"];
    }
    if(teacher.school){
        [dict setObject:teacher.school forKey:@"school"];
    }
    if(teacher.QQ){
        [dict setObject:teacher.QQ forKey:@"QQ"];
    }
    if(teacher.teaPaper){
        [dict setObject:teacher.teaPaper forKey:@"teaPaper"];
    }
    if(teacher.teaProject){
        [dict setObject:teacher.teaProject forKey:@"teaProject"];
    }
    if(teacher.stuRequire){
        [dict setObject:teacher.stuRequire forKey:@"stuRequire"];
    }
    if(teacher.remarks){
        [dict setObject:teacher.remarks forKey:@"remarks"];
    }
    if(teacher.sex){
        [dict setObject:teacher.sex forKey:@"sex"];
    }
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:ksaveTeacher withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            MHTeacher *teacher=nil;
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSDictionary *values=[dictData objectForKey:@"value"];
                teacher=[MHTeacher teacherWithDict:values];
            }else{
            }
            block(teacher, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_teacherList_WithTeaTitle:(NSString *)teaTitle direction:(NSString *)direction pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id, NSError *))block{
//    MHTeacher *teacher=[self getTeacher];
//    MHTeacher *teacher1=[self getTeacher1];
//    NSMutableArray *arry=[NSMutableArray arrayWithObjects:teacher,teacher1, nil];
//    block(arry,nil);
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (teaTitle) {
        [dict setObject:teaTitle forKey:@"teaTitle"];
    }
    if (direction) {
        [dict setObject:direction forKey:@"direction"];
    }
    if (pageNum) {
        [dict setObject:pageNum forKey:@"pageNum"];
    }
    if (pageSize) {
        [dict setObject:pageSize forKey:@"pageSize"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kteacherList withParams:dict withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSMutableArray *dataArry=[NSMutableArray arrayWithCapacity:1];
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSArray *values=[dictData objectForKey:@"value"];
                if(values!=nil&&values.count>0){
                    for (NSDictionary *dict in values) {
                        MHTeacher *teacher=[MHTeacher teacherWithDict:dict];
                        teacher.isSelect=[[MHStudentManager sharedManager]getkUserDefaultsAndjudgeSelectTeaId:teacher.teaId];
                        [dataArry addObject:teacher];
                    }
                }
            }else{
            }
            block(dataArry, nil);
        }else{
            block(nil, error);
        }
    }];
}
- (void)request_addTeacher_WithTeaId:(NSString *)teaId pwd:(NSString *)pwd name:(NSString *)name andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (teaId) {
        [dict setObject:teaId forKey:@"id"];
    }
    if(pwd){
        [dict setObject:pwd forKey:@"pwd"];
    }
    if(name){
        [dict setObject:name forKey:@"name"];
    }
    [dict setObject:[self getRandomAvatar] forKey:@"avatar"];
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kaddTeacher withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSString *info=@"失败";
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                info=@"成功";
            }else if([status intValue]==111){
                [MHGlobalFunction showHUD:@"工号已经存在"];
            }else{
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_teacherLogin_WithTeaId:(NSString *)teaId pwd:(NSString *)pwd andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (teaId) {
        [dict setObject:teaId forKey:@"id"];
    }
    if(pwd){
        [dict setObject:pwd forKey:@"pwd"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kteacherLogin withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            MHTeacher *teacher=nil;
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSDictionary *values=[dictData objectForKey:@"value"];
                teacher=[MHTeacher teacherWithDict:values];
            }else{
            }
            block(teacher, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_adminLogin_WithAdminId:(NSString *)adminId pwd:(NSString *)pwd andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (adminId) {
        [dict setObject:adminId forKey:@"id"];
    }
    if(pwd){
        [dict setObject:pwd forKey:@"pwd"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kadminLogin withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSNumber *status=[dictData objectForKey:@"status"];
            NSString *info=@"失败";
            if([status intValue]==0){
                info=@"成功";
            }else{
                
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_teacherFenPeiList_andBlock:(void (^)(id, NSError *))block{
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kteacherFenPeiList withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSMutableArray *dataArry=[NSMutableArray arrayWithCapacity:1];
            NSNumber *status=[dictData objectForKey:@"status"];
            if([status intValue]==0){
                NSArray *values=[dictData objectForKey:@"value"];
                if(values!=nil&&values.count>0){
                    for (NSDictionary *dict in values) {
                        MHTeacher *teacher=[MHTeacher teacherWithDict:dict];
                        [dataArry addObject:teacher];
                    }
                }
            }else{
            }
            block(dataArry, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_modifyTeacherPwd_WithTeaId:(NSString *)teaId pwd:(NSString *)pwd newPwd:(NSString *)newPwd andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (teaId) {
        [dict setObject:teaId forKey:@"id"];
    }
    if(pwd){
        [dict setObject:pwd forKey:@"pwd"];
    }
    if(newPwd){
        [dict setObject:newPwd forKey:@"newPwd"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kmodifyTeacherPwd withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSNumber *status=[dictData objectForKey:@"status"];
            NSString *info=@"失败";
            if([status intValue]==0){
                info=@"成功";
            }else{
                
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (void)request_modifyAdminPwd_WithAdminId:(NSString *)AdminId pwd:(NSString *)pwd newPwd:(NSString *)newPwd andBlock:(void (^)(id, NSError *))block{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:1];
    if (AdminId) {
        [dict setObject:AdminId forKey:@"id"];
    }
    if(pwd){
        [dict setObject:pwd forKey:@"pwd"];
    }
    if(newPwd){
        [dict setObject:newPwd forKey:@"newPwd"];
    }
    
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:kmodifyAdminPwd withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary *dictData=[NSDictionary changeType:data];
            NSNumber *status=[dictData objectForKey:@"status"];
            NSString *info=@"失败";
            if([status intValue]==0){
                info=@"成功";
            }else{
                
            }
            block(info, nil);
        }else{
            block(nil, error);
        }
    }];
}

- (MHTime *)getTime{
    MHTime *time=[[MHTime alloc]init];
    time.timeId=@"1";
    time.startTime=@"2016-04-28 12:00:00";
    time.endTime=@"2016-04-29 12:00:00";
    time.timeType=[NSNumber numberWithInt:1];
    time.timeStatus=[NSNumber numberWithInt:1];
    return time;
}

- (MHChoose *)getChoose{
    MHChoose *choose=[[MHChoose alloc]init];
    choose.chooseId=@"1";
    choose.stuId=@"120104400114";
    choose.teaId=@"20080201";
    choose.wishNum=[NSNumber numberWithInt:1];
    choose.stuStatus=[NSNumber numberWithInt:0];
    choose.teaStatus=[NSNumber numberWithInt:1];
    
    choose.stuName=@"陆伟";
    choose.stuContact=@"15757135915";
    choose.teaName=@"张帅";
    choose.teaContact=@"13457907963";
    choose.avatar=@"http://vomoho-pd.image.alimmdn.com/a4889d21-09b7-4612-9a5b-2b1c9210ceb8";
    choose.email=@"zs760914@sina.com";
    choose.major=@"软件工程";
    return choose;
}

- (MHStudent *)getStudent{
    MHStudent *student=[[MHStudent alloc]init];
    student.stuId=@"120104400114";
    student.stuName=@"陆伟";
    student.sex=[NSNumber numberWithInt:1];
    student.avatar=@"http://vomoho-pd.image.alimmdn.com/b6c2d6f5-9a5b-498f-abd0-7d112ad81b3a";
    student.clazz=@"12软件工程";
    student.major=@"软件工程";
    student.contact=@"15757135915";
    student.email=@"785080572@qq.com";
    student.rank=[NSNumber numberWithInt:1];
    student.honour=@"优秀学生二等奖学金";
    student.interst=@"iOS编程、阅读外文开发文档、踢足球、听音乐";
    student.works=@"《千里马随身通》、《其乐组织》";
    student.experience=@"担任过14级的新生辅导员助理，住楼在新生宿舍，帮助新生熟悉和适应大学生活。参加中国服务外包创新创业大赛，获得国家级赛事的银奖荣誉。帮助研究生编写论文的实验部分，学习并实践过蚂蚁算法等高级算法。曾在杭州大关社区进行电脑义诊，暑期社会实践活动。加入创业团队创业，开发了一款名为“其乐组织”的app，在app store上线。";
    return student;
}

- (MHTeacher *)getTeacher{
    MHTeacher *teacher=[[MHTeacher alloc]init];
    teacher.teaId=@"20050027";
    teacher.teaName=@"张帅";
    teacher.sex=[NSNumber numberWithInt:1];
    teacher.avatar=@"http://vomoho-pd.image.alimmdn.com/a4889d21-09b7-4612-9a5b-2b1c9210ceb8";
    teacher.teaTitle=@"教授";
    teacher.direction=@"机器学习、人工智能";
    teacher.contact=@"13457907963";
    teacher.email=@"zs760914@sina.com";
    teacher.teaPaper=@"《iOS APP开发安全框架设计与实现》、《学生与导师网上双向选择的设计与实现》";
    teacher.teaProject=@"《制造业效率优化服务-蚂蚁算法》";
    teacher.honour=@"浙江财经大学优秀教师";
    teacher.stuRequire=@"iOS编程、阅读外文开发文档、踢足球、听音乐";
    return teacher;
}
- (MHTeacher *)getTeacher1{
    MHTeacher *teacher=[[MHTeacher alloc]init];
    teacher.teaId=@"20000030";
    teacher.teaName=@"陈琰宏";
    teacher.sex=[NSNumber numberWithInt:1];
    teacher.avatar=@"http://vomoho-pd.image.alimmdn.com/user/264.jpg";
    teacher.teaTitle=@"讲师";
    teacher.direction=@"算法学习、ACM";
    teacher.contact=@"13457909999";
    teacher.email=@"chenyankong@sina.com";
    teacher.teaPaper=@"《iOS APP开发安全框架设计与实现》、《学生与导师网上双向选择的设计与实现》";
    teacher.teaProject=@"《制造业效率优化服务-蚂蚁算法》";
    teacher.honour=@"浙江财经大学优秀教师";
    teacher.stuRequire=@"iOS编程、阅读外文开发文档、踢足球、听音乐";
    return teacher;
}

- (MHWish *)getWish{
    MHWish *wish=[[MHWish alloc]init];
    wish.wishId=@"1";
    wish.teaId=@"20080201";
    wish.stuId=@"120104400114";
    wish.wishNum=[NSNumber numberWithInt:1];
    wish.content=@"我是一个您值得拥有的学生";
    wish.stuName=@"陆伟";
    wish.stuContact=@"15757135915";
    wish.teaName=@"张帅";
    wish.teaContact=@"15757135915";
    return wish;
}

- (NSString *)getRandomAvatar{
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:1];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/15AB63B8-3CBA-45EF-A9F1-4971597149B7"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/B031D2AF-46D8-4694-8A4E-48388E84911C"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/09A08E9A-5370-47A2-8067-BC18215104D7"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/EE77FBED-225F-4C84-B1CB-9AE45D5B121D"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/6DF1B404-52A6-4C19-93FA-634031389796"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/E602509B-508D-4500-A2E6-D10792B86B26"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/874FBAF5-9F26-43E3-BF73-B1567D24C09A"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/528A5316-D9BE-41E5-94B6-F8B6ACB28CED"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/3478C65F-00C4-4802-A40E-618758C7379B"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/7415421B-7DB1-473A-8C48-19D72E53F4A9"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/4A3395C7-25AE-4282-9587-08E59A5C7252"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/92F60494-9544-4243-9BA6-38974552C43A"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/A4B03733-4221-4E12-8B46-ADDF0AEB4755"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/13B379EF-B0CC-4D50-B375-82D02F34ED83"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/3FE339E0-9D3B-4DFB-A362-B5DEE1DC3B47"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/9ED38074-F908-4A7A-820C-97048E8CF923"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/AEC2C943-6CC8-401E-9498-9FF3F768C05A"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/image_b00191f517574a84947a4cb110d88d2e"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/368.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/363.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/372.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/371.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/369.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/375.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/374.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/376.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/378.jpg"];
    [arry addObject:@"http://vomoho-pd.image.alimmdn.com/user/381.jpg"];
    
    int index=arc4random()%arry.count;
    return [arry objectAtIndex:index];
    
}
@end
