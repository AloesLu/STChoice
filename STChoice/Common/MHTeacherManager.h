//
//  MHTeacherManager.h
//  STChoice
//
//  Created by AloesLu on 16/5/3.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MHTeacher,MHChoose;
@interface MHTeacherManager : NSObject
+ (instancetype)sharedManager;

- (void)setTeacherData:(MHTeacher *)teacher;
- (MHTeacher *)getTeacherData;

- (void)setkUserDefaults_teacher_choose_arry:(NSMutableArray *)teacher_choose_arry;

- (void)addStudentWish:(MHChoose *)choose;

- (NSMutableArray *)getkUserDefaults_teacher_choose_arry;

- (void)setkUserDefaults_addhasSelectStudent:(NSString *)stuId;
- (BOOL)getkUserDefaultsAndjudgeSelectStuId:(NSString *)stuId;
@end
