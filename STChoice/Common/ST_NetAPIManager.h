//
//  ST_NetAPIManager.h
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MHTime,MHStudent,MHTeacher,MHTag,MHWish,MHChoose;
@interface ST_NetAPIManager : NSObject

+ (instancetype)sharedManager;
/**
 *  MHTime
 */
//获取控制时间段数据
- (void)request_timeList_WithTimeStatus:(NSNumber *)timeStatus andBlock:(void (^)(id data, NSError *error))block;
//保存时间段
- (void)request_saveTime_WithTime:(MHTime *)time andBlock:(void (^)(id data, NSError *error))block;

/**
 *  MHChoose
 */
- (void)request_saveChoose_WithChoose:(MHChoose *)choose andBlock:(void (^)(id data, NSError *error))block;
//管理员获取选择结果列表
- (void)request_chooseResultList_WithStuStatus:(NSNumber *)stuStatus teaStatus:(NSNumber *)teaStatus teaId:(NSString *)teaId stuId:(NSString *)stuId pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id data, NSError *error))block;
- (void)request_chooseTeacherResultList_WithTeaTitle:(NSString *)teaTitle pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id data, NSError *error))block;
- (void)request_chooseStudentResultList_WithClazz:(NSString *)clazz major:(NSString *)major pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id data, NSError *error))block;
//随机分配保存选择
- (void)request_saveFenPeiChoose_WithTeaId:(NSString *)teaId selectNum:(NSNumber *)selectNum andBlock:(void (^)(id, NSError *))block;

/**
 *  MHStudent
 */
//获取学生个人详情
- (void)request_getStudentDetail_WithStuId:(NSString *)stuId andBlock:(void (^)(id data, NSError *error))block;
//保存或修改学生个人详情
- (void)request_saveOrUpdateStudent_WithStudent:(MHStudent *)student andBlock:(void (^)(id data, NSError *error))block;
//学生列表
- (void)request_studentList_WithMajor:(NSString *)major clazz:(NSString *)clazz pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id data, NSError *error))block;
//添加学生用户
- (void)request_addStudent_WithStuId:(NSString *)stuId pwd:(NSString *)pwd name:(NSString *)name andBlock:(void (^)(id data, NSError *error))block;
//验证学生登陆
- (void)request_studentLogin_WithStuId:(NSString *)stuId pwd:(NSString *)pwd andBlock:(void (^)(id data, NSError *error))block;
- (void)request_modifyStudentPwd_WithStuId:(NSString *)stuId pwd:(NSString *)pwd newPwd:(NSString *)newPwd andBlock:(void (^)(id data, NSError *error))block;
/**
 *  MHWish
 */
//填写志愿
- (void)request_saveWish_WithWish:(MHWish *)wish andBlock:(void (^)(id data, NSError *error))block;
//获取志愿列表
- (void)request_stuWishList_WithStuId:(NSString *)stuId teaId:(NSString *)teaId wishNum:(NSNumber *)wishNum pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id data, NSError *error))block;

/**
 *  MHTeacher
 */
//获取教师个人详情
- (void)request_getTeacherDetail_WithTeaId:(NSString *)teaId andBlock:(void (^)(id data, NSError *error))block;
//保存或者修改教师个人信息
- (void)request_saveOrUpdateTeacher_WithTeacher:(MHTeacher *)teacher andBlock:(void (^)(id data, NSError *error))block;
//教师列表
- (void)request_teacherList_WithTeaTitle:(NSString *)teaTitle direction:(NSString *)direction pageNum:(NSNumber *)pageNum pageSize:(NSString *)pageSize andBlock:(void (^)(id data, NSError *error))block;
//增加教师用户
- (void)request_addTeacher_WithTeaId:(NSString *)teaId pwd:(NSString *)pwd name:(NSString *)name andBlock:(void (^)(id data, NSError *error))block;
//教师登陆验证
- (void)request_teacherLogin_WithTeaId:(NSString *)teaId pwd:(NSString *)pwd andBlock:(void (^)(id data, NSError *error))block;
//管理员登陆验证
- (void)request_adminLogin_WithAdminId:(NSString *)adminId pwd:(NSString *)pwd andBlock:(void (^)(id data, NSError *error))block;

- (void)request_teacherFenPeiList_andBlock:(void (^)(id data, NSError *error))block;

- (void)request_modifyTeacherPwd_WithTeaId:(NSString *)teaId pwd:(NSString *)pwd newPwd:(NSString *)newPwd andBlock:(void (^)(id data, NSError *error))block;
- (void)request_modifyAdminPwd_WithAdminId:(NSString *)adminId pwd:(NSString *)pwd newPwd:(NSString *)newPwd andBlock:(void (^)(id data, NSError *error))block;

- (MHStudent *)getStudent;
- (MHTeacher *)getTeacher;
@end
